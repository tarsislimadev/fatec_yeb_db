-- -- Data Schema

-- Table companies

CREATE TABLE IF NOT EXISTS companies (
    id SERIAL PRIMARY KEY,
    cnpj VARCHAR(18) NOT NULL,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255) NOT NULL,
    cidade VARCHAR(255) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    pais VARCHAR(255) NOT NULL,
    data_abertura DATE NOT NULL,
    situacao_cadastral VARCHAR(255) NOT NULL,
    data_situacao_cadastral DATE NOT NULL,
    motivo_situacao_cadastral VARCHAR(255) NOT NULL,
    natureza_juridica VARCHAR(255) NOT NULL,
    atividade_principal VARCHAR(255) NOT NULL,
    atividade_secundaria VARCHAR(255) NOT NULL,
    capital_social DECIMAL(10, 2) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    numero VARCHAR(255) NOT NULL,
    complemento VARCHAR(255) NOT NULL,
    bairro VARCHAR(255) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    telefone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    website VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Table owners

CREATE TABLE IF NOT EXISTS owners (
    id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    email VARCHAR(255) NOT NULL,
    telefone VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Table partners

CREATE TABLE IF NOT EXISTS partners (
    id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    email VARCHAR(255) NOT NULL,
    telefone VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Table financial_statements

CREATE TABLE IF NOT EXISTS financial_statements (
    id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    receita_bruta DECIMAL(10, 2) NOT NULL,
    receita_liquida DECIMAL(10, 2) NOT NULL,
    custo_das_vendas DECIMAL(10, 2) NOT NULL,
    lucro_bruto DECIMAL(10, 2) NOT NULL,
    despesas_operacionais DECIMAL(10, 2) NOT NULL,
    lucro_operacional DECIMAL(10, 2) NOT NULL,
    lucro_liquido DECIMAL(10, 2) NOT NULL,
    ativo_total DECIMAL(10, 2) NOT NULL,
    passivo_total DECIMAL(10, 2) NOT NULL,
    patrimonio_liquido DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Table financial_statements_quarterly

CREATE TABLE IF NOT EXISTS financial_statements_quarterly (
    id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    trimestre INTEGER NOT NULL,
    receita_bruta DECIMAL(10, 2) NOT NULL,
    receita_liquida DECIMAL(10, 2) NOT NULL,
    custo_das_vendas DECIMAL(10, 2) NOT NULL,
    lucro_bruto DECIMAL(10, 2) NOT NULL,
    despesas_operacionais DECIMAL(10, 2) NOT NULL,
    lucro_operacional DECIMAL(10, 2) NOT NULL,
    lucro_liquido DECIMAL(10, 2) NOT NULL,
    ativo_total DECIMAL(10, 2) NOT NULL,
    passivo_total DECIMAL(10, 2) NOT NULL,
    patrimonio_liquido DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Table financial_statements_monthly

CREATE TABLE IF NOT EXISTS financial_statements_monthly (
    id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    receita_bruta DECIMAL(10, 2) NOT NULL,
    receita_liquida DECIMAL(10, 2) NOT NULL,
    custo_das_vendas DECIMAL(10, 2) NOT NULL,
    lucro_bruto DECIMAL(10, 2) NOT NULL,
    despesas_operacionais DECIMAL(10, 2) NOT NULL,
    lucro_operacional DECIMAL(10, 2) NOT NULL,
    lucro_liquido DECIMAL(10, 2) NOT NULL,
    ativo_total DECIMAL(10, 2) NOT NULL,
    passivo_total DECIMAL(10, 2) NOT NULL,
    patrimonio_liquido DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

Table financial_statements_quarterly

CREATE TABLE IF NOT EXISTS financial_statements_quarterly (
    id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    trimestre INTEGER NOT NULL,
    receita_bruta DECIMAL(10, 2) NOT NULL,
    receita_liquida DECIMAL(10, 2) NOT NULL,
    custo_das_vendas DECIMAL(10, 2) NOT NULL,
    lucro_bruto DECIMAL(10, 2) NOT NULL,
    despesas_operacionais DECIMAL(10, 2) NOT NULL,
    lucro_operacional DECIMAL(10, 2) NOT NULL,
    lucro_liquido DECIMAL(10, 2) NOT NULL,
    ativo_total DECIMAL(10, 2) NOT NULL,
    passivo_total DECIMAL(10, 2) NOT NULL,
    patrimonio_liquido DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table financial_statements_monthly

CREATE TABLE IF NOT EXISTS financial_statements_monthly (
    id SERIAL PRIMARY KEY,
    company_id INTEGER NOT NULL,
    ano INTEGER NOT NULL,
    mes INTEGER NOT NULL,
    receita_bruta DECIMAL(10, 2) NOT NULL,
    receita_liquida DECIMAL(10, 2) NOT NULL,
    custo_das_vendas DECIMAL(10, 2) NOT NULL,
    lucro_bruto DECIMAL(10, 2) NOT NULL,
    despesas_operacionais DECIMAL(10, 2) NOT NULL,
    lucro_operacional DECIMAL(10, 2) NOT NULL,
    lucro_liquido DECIMAL(10, 2) NOT NULL,
    ativo_total DECIMAL(10, 2) NOT NULL,
    passivo_total DECIMAL(10, 2) NOT NULL,
    patrimonio_liquido DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
