# Crawler

O crawler é responsável por coletar dados de empresas e pessoas físicas.

## Tecnologias

- Python
- BeautifulSoup
- Requests
- Pandas
- NumPy
- spaCy
- NLTK

## Uso de APIs de CNPJ

O crawler utiliza APIs públicas e privadas para buscar dados adicionais e validar informações de empresas a partir de seus CNPJs. O sistema faz requisições enviando o CNPJ e recebe dados como Razão Social, Nome Fantasia, Situação Cadastral, Data de Abertura, Telefones, E-mails e até mesmo o Quadro de Sócios e Administradores (QSA). 

Atualmente, o projeto utiliza a **Brasil API** de forma primária para realizar consultas rápidas e gratuitas do CNPJ das empresas, e pode ser integrado facilmente com outras plataformas como a **CNPJA (Open API)**. Esses dados coletados formam a base fundamental para as etapas seguintes de processamento da IA e validação dos contatos.

## Fontes de dados

- [Econodata](https://www.econodata.com.br/)

- [CNPJ Biz](https://cnpj.biz/)

- [Brasil API](https://brasilapi.com.br/v1/cnpj/)

- [CNPJA (Open API)](https://cnpja.com/en/api/open)
