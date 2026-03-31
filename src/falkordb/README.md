# banco de dados

## entidades

### pessoa_juridica

- CNPJ
- Razão Social
- Nome Fantasia

### pessoa_fisica

- CPF
- Nome

### unidade

- Endereço

### Telefone

Pode pertencer a uma pessoa física ou jurídica

### E-mail

Pode pertencer a uma pessoa física ou jurídica

## relacionamentos

### pessoa_juridica_unidade

- pessoa_juridica
- unidade

### pessoa_juridica_telefone

- pessoa_juridica
- telefone

### pessoa_fisica_telefone

- pessoa_fisica
- telefone

### pessoa_juridica_email

- pessoa_juridica
- email

### pessoa_fisica_email

- pessoa_fisica
- email
