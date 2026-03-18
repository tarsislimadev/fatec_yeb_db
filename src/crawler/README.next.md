# Crawler

O crawler é responsável por coletar dados de empresas e pessoas físicas.

Para encontrar novos CNPJs, utilize o site [Econodata](https://www.econodata.com.br/).

Executa instancias do Google Chrome Remote Debug Protocol para coletar dados de empresas e pessoas físicas nas páginas do Econodata e CNPJ Biz.

Salva os CNPJs encontrados no banco de dados (Docker Compose service `database`).

Para cada CNPJ encontrado, busca dados utilizando APIs como Brasil API e CNPJA.

Salva os dados encontrados no banco de dados (Docker Compose service `database`).

## Fontes de dados

- [Econodata](https://www.econodata.com.br/)

- [CNPJ Biz](https://cnpj.biz/)

- [Brasil API](https://brasilapi.com.br/v1/cnpj/)

- [CNPJA (Open API)](https://cnpja.com/en/api/open)
