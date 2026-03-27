const { spawn } = require('child_process')

const run = async (cnpj = '83887703000100') => {
  return await new Promise((res, rej) => {
    const state = { stdout: '', stderr: '' }

    const [command, ...args] = `curl -sSL https://www.econodata.com.br/consulta-empresa?filtro=${cnpj}`.split(' ')

    console.log({ command, args })

    const ls = spawn(command, args)

    ls.stdout.on('data', (...data) => state.stdout += data)

    ls.stderr.on('data', (...data) => state.stderr += data)

    ls.on('close', () => state.stderr ? rej(state.stderr.toString()) : res(state.stdout.toString()))
  })
}

module.exports = { run }
