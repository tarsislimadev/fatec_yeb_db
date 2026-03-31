import { run } from './spawn.js'

import sqlite3 from 'sqlite3'

const ee = new EventTarget()

const state = { cnpjs: [] }

const saveManyCnpjsOnDatabase = async () => {
  state.cnpjs.map((cnpj) => {
    db.run(`INSERT INTO cnpjs (cnpj, created_at) VALUES (?, ?)`, [cnpj.replace(/\D/g, ''), +(new Date())])
    console.log('cnpj saved', { cnpj })
  })
}

const searchCNPJ = async (cnpj = '') => {
  await run(cnpj)
    .then((html) => html.match(/\d\d\.?\d\d\d\.?\d\d\d\/\d\d\d\d[-]?\d\d/ig))
    .then((cnpjs) => state.cnpjs = cnpjs.concat(state.cnpjs).filter((cnpj) => !state.cnpjs.includes(cnpj)))
    .then(() => saveManyCnpjsOnDatabase())
    .then(() => state.cnpjs.map((cnpj) => searchCNPJ(cnpj)))
    .catch((err) => console.error('Error searching CNPJ', err))
}

ee.addEventListener('db.ready', () => searchCNPJ())

const db = new sqlite3.Database(`./fatec.yeb.${Date.now()}.db`)

db.serialize(() => {
  db.run(`CREATE TABLE IF NOT EXISTS cnpjs (cnpj TEXT PRIMARY KEY, created_at TEXT)`)
  ee.dispatchEvent(new Event('db.ready'))
  console.log('db.ready')
})
