import json
import os
from datetime import datetime, timezone

import psycopg2
import requests
from flask import Flask, jsonify, request
from flask_cors import CORS
from psycopg2.extras import RealDictCursor


app = Flask(__name__)
CORS(app)


DB_CONFIG = {
	"host": os.getenv("DB_HOST", "db"),
	"port": os.getenv("DB_PORT", "5432"),
	"dbname": os.getenv("DB_NAME", "postgres"),
	"user": os.getenv("DB_USER", "postgres"),
	"password": os.getenv("DB_PASSWORD", "postgres"),
}

BRASIL_API_BASE = os.getenv("CNPJ_API_BASE", "https://brasilapi.com.br/api/cnpj/v1")


def normalize_cnpj(cnpj):
	return "".join(char for char in cnpj if char.isdigit())


def is_valid_cnpj(cnpj):
	digits = normalize_cnpj(cnpj)
	return len(digits) == 14


def get_db_connection():
	return psycopg2.connect(**DB_CONFIG)


def log_lookup(cnpj, source, status, details="", company_id=None):
	with get_db_connection() as conn:
		with conn.cursor() as cur:
			cur.execute(
				"""
				INSERT INTO lookup_audit (company_id, cnpj, source, status, details)
				VALUES (%s, %s, %s, %s, %s)
				""",
				(company_id, cnpj, source, status, details),
			)


def fetch_cnpj_data(cnpj):
	url = f"{BRASIL_API_BASE}/{cnpj}"
	response = requests.get(url, timeout=12)
	response.raise_for_status()
	return response.json()


def save_company(cnpj, payload, source):
	legal_name = payload.get("razao_social") or payload.get("nome")
	trade_name = payload.get("nome_fantasia")
	main_cnae = payload.get("cnae_fiscal_descricao")
	phone = payload.get("ddd_telefone_1")
	email = payload.get("email")

	with get_db_connection() as conn:
		with conn.cursor(cursor_factory=RealDictCursor) as cur:
			cur.execute(
				"""
				INSERT INTO companies (
					cnpj,
					legal_name,
					trade_name,
					main_cnae,
					phone,
					email,
					status,
					source,
					verified,
					raw_data,
					updated_at
				)
				VALUES (%s, %s, %s, %s, %s, %s, 'found', %s, true, %s::jsonb, NOW())
				ON CONFLICT (cnpj)
				DO UPDATE SET
					legal_name = EXCLUDED.legal_name,
					trade_name = EXCLUDED.trade_name,
					main_cnae = EXCLUDED.main_cnae,
					phone = EXCLUDED.phone,
					email = EXCLUDED.email,
					status = 'verified',
					source = EXCLUDED.source,
					verified = true,
					raw_data = EXCLUDED.raw_data,
					updated_at = NOW()
				RETURNING id, cnpj, legal_name, trade_name, main_cnae, phone, email, status, source, verified, updated_at
				""",
				(
					cnpj,
					legal_name,
					trade_name,
					main_cnae,
					phone,
					email,
					source,
					json.dumps(payload),
				),
			)
			company = cur.fetchone()

			qsa = payload.get("qsa") or []
			if qsa:
				cur.execute("DELETE FROM contacts WHERE company_id = %s AND source = %s", (company["id"], source))
				for partner in qsa:
					cur.execute(
						"""
						INSERT INTO contacts (company_id, name, role, source)
						VALUES (%s, %s, %s, %s)
						""",
						(
							company["id"],
							partner.get("nome_socio") or partner.get("nome"),
							partner.get("qualificacao_socio") or partner.get("qual"),
							source,
						),
					)

			return company


@app.get("/health")
def health():
	try:
		with get_db_connection() as conn:
			with conn.cursor() as cur:
				cur.execute("SELECT 1")
				cur.fetchone()
		return jsonify({"status": "ok", "timestamp": datetime.now(timezone.utc).isoformat()})
	except Exception as exc:
		return jsonify({"status": "error", "detail": str(exc)}), 500


@app.get("/api/companies")
def list_companies():
	limit = request.args.get("limit", default=20, type=int)
	limit = 1 if limit < 1 else min(limit, 100)

	with get_db_connection() as conn:
		with conn.cursor(cursor_factory=RealDictCursor) as cur:
			cur.execute(
				"""
				SELECT id, cnpj, legal_name, trade_name, main_cnae, phone, email, status, source, verified, created_at, updated_at
				FROM companies
				ORDER BY updated_at DESC NULLS LAST, created_at DESC
				LIMIT %s
				""",
				(limit,),
			)
			records = cur.fetchall()
	return jsonify(records)


@app.post("/api/cnpj/lookup")
def cnpj_lookup():
	data = request.get_json(silent=True) or {}
	raw_cnpj = data.get("cnpj", "")

	if not raw_cnpj:
		return jsonify({"error": "cnpj is required"}), 400

	cnpj = normalize_cnpj(raw_cnpj)
	if not is_valid_cnpj(cnpj):
		return jsonify({"error": "invalid cnpj format, expected 14 digits"}), 400

	try:
		payload = fetch_cnpj_data(cnpj)
		company = save_company(cnpj, payload, source="brasilapi")
		log_lookup(cnpj, source="brasilapi", status="found", details="Lookup completed", company_id=company["id"])
		return jsonify(
			{
				"status": "found",
				"company": company,
				"contactsCount": len(payload.get("qsa") or []),
			}
		)
	except requests.HTTPError as exc:
		detail = f"HTTP error from CNPJ provider: {exc.response.status_code if exc.response else 'unknown'}"
		log_lookup(cnpj, source="brasilapi", status="blocked", details=detail)
		return jsonify({"status": "blocked", "error": detail}), 502
	except requests.RequestException as exc:
		detail = f"Failed to reach CNPJ provider: {str(exc)}"
		log_lookup(cnpj, source="brasilapi", status="pending", details=detail)
		return jsonify({"status": "pending", "error": detail}), 503
	except Exception as exc:
		log_lookup(cnpj, source="internal", status="blocked", details=str(exc))
		return jsonify({"status": "blocked", "error": "Unexpected server error"}), 500


if __name__ == "__main__":
	app.run(host="0.0.0.0", port=8080)
