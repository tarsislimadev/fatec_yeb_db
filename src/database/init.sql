CREATE TABLE IF NOT EXISTS companies (
	id BIGSERIAL PRIMARY KEY,
	cnpj VARCHAR(14) NOT NULL UNIQUE,
	legal_name TEXT,
	trade_name TEXT,
	main_cnae TEXT,
	phone TEXT,
	email TEXT,
	status VARCHAR(24) NOT NULL DEFAULT 'pending',
	source VARCHAR(100) NOT NULL DEFAULT 'manual',
	verified BOOLEAN NOT NULL DEFAULT false,
	raw_data JSONB,
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
	updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS contacts (
	id BIGSERIAL PRIMARY KEY,
	company_id BIGINT NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
	name TEXT,
	role TEXT,
	phone TEXT,
	email TEXT,
	source VARCHAR(100) NOT NULL DEFAULT 'manual',
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS lookup_audit (
	id BIGSERIAL PRIMARY KEY,
	company_id BIGINT REFERENCES companies(id) ON DELETE SET NULL,
	cnpj VARCHAR(14) NOT NULL,
	source VARCHAR(100) NOT NULL,
	status VARCHAR(24) NOT NULL,
	details TEXT,
	created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_companies_cnpj ON companies(cnpj);
CREATE INDEX IF NOT EXISTS idx_companies_status ON companies(status);
CREATE INDEX IF NOT EXISTS idx_lookup_audit_cnpj ON lookup_audit(cnpj);
