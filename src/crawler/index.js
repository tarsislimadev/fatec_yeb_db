const run = async (cnpj = '47339227000120') => {
  const url = `https://www.econodata.com.br/consulta-empresa?filtro=${cnpj}`

  console.log({ url })

  const html = await fetch(url).then(r => r.text())

  console.log({ html })

  const cnpjs = html.match(/\d\d\.?\d\d\d\.?\d\d\d\/\d\d\d\d[-]?\d\d/ig)

  console.log({ cnpjs })
}

run()
