import { createClient } from 'redis'

import { run } from './spawn.js'

const client = createClient({
  url: 'redis://redis:6379'
})

client.connect()

const saveManyCnpjsOnDatabase = async ({ cnpjs } = {}) => {
  cnpjs.map(async (cnpj) => {
    await client.set(`cnpjs.${cnpj}.created_at`, new Date().toISOString())

    console.log('cnpj saved', { cnpj })
  })
}

const searchCNPJ = async (cnpj = '') => {
  const state = { cnpjs: [] }

  await run(cnpj)
    .then((html) => html.match(/\d\d\.?\d\d\d\.?\d\d\d\/\d\d\d\d[-]?\d\d/ig))
    .then((cnpjs) => state.cnpjs = cnpjs)
    .then(() => saveManyCnpjsOnDatabase({ cnpjs: state.cnpjs }))
    .then(() => state.cnpjs.map(async (cnpj) => await searchCNPJ(cnpj)))
}

searchCNPJ()
