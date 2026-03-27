const fs = require('fs')

const state = { companies: [] }

const searchCNPJ = async (cnpj = '83887703000100') => {
  const url = `https://www.econodata.com.br/consulta-empresa?filtro=${cnpj}`

  console.log({ cnpj, url })

  const html = await fetch(url).then(r => r.text())

  const cnpjs = html.match(/\d\d\.?\d\d\d\.?\d\d\d\/\d\d\d\d[-]?\d\d/ig)

  state.companies = state.companies.concat(cnpjs.filter((cnpj, index) => state.companies.indexOf(cnpj) === index))
}

searchCNPJ()

const saveCNPJ = async () => {
  const cnpj = state.companies.shift()

  const data = await fetch(`https://brasilapi.com.br/api/cnpj/v1/${cnpj}`).then(r => r.json())

  fs.writeFileSync(`./cnpj.${cnpj}.json`, JSON.stringify(data))

  setTimeout(() => saveCNPJ(), 1500)
}

setTimeout(() => saveCNPJ(), 1500)
