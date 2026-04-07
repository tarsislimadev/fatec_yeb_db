# Scopes

In first step, our project has to get inputed a CNPJ, search for Business Data (name, CNAEs, people) and their phone.

Then, from phone numbers, the project has to get people contacted by WhatsApp (message and/or phone call) for asking detail about client's issues.

## Plan

1. Start with CNPJ input and validate the company through official and secondary sources.
2. Enrich the record with company name, CNAEs, partners, and public contact data.
3. Rank the found phone numbers and decide which ones are worth a primary contact attempt.
4. Use WhatsApp or phone outreach only for the missing fields that secondary research could not confirm.
5. Store the results with a status flag: "found", "verified", "pending", or "blocked for compliance reasons".

## Tools

1. CNPJ APIs: Brasil API and CNPJA for official company data and QSA lookup.
2. Enrichment sources: Econodata, CNPJ.biz, company websites, and public directories.
3. Automation stack: Python for crawling, PostgreSQL for persistence, Docker for local orchestration.
4. AI stack: Ollama with LangChain for extraction, classification, and interview flows.
5. Communication stack: WhatsApp API or telephony provider for primary contact and follow-up.

## More

1. Keep the process aligned with LGPD and ESG review before primary contact.
2. Prefer secondary research first so primary contact is only used as a fallback.
3. Add an audit trail for every source used and every field that was filled or verified.
4. Allow the customer to choose which fields are required, such as name, email, phone, and role.
5. Consider a human approval step before sending any automated WhatsApp or phone outreach.
