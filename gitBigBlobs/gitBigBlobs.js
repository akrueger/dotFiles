#!/usr/local/bin/Node

console.time('<<< TOTAL PROCESS >>>')
const execFileSync = require('child_process').execFileSync
const execSync = require('child_process').execSync
const spawn = require('child_process').spawn
const Queue = require('./lib/queue.js')
const split = require('split2')
const vsprintf = require('sprintf-js').vsprintf

const MiB = 1024 ** 2
const threshold = parseFloat(process.argv[2] || 50) * MiB
if(!Number.isSafeInteger(parseInt(threshold)) || threshold < 0) {
  throw new Error('Invalid threshold argument. Threshold must be a number greater than or equal to zero.')
}

const shellPath = '/usr/local/bin/zsh'
const packObjectPackSize = new Map()
const bigFiles = {}
const gitDir = execFileSync('git', ['rev-parse', '--git-dir']).toString().trim()
const gitPackObjectCmd = `git verify-pack -v ${gitDir}/objects/pack/pack-*.idx | rg blob`
const commitTreeProcessPromises = []
const commitQueue = Queue.createLinkedListQueue()

const systemProcessesLimit = parseInt(execFileSync('ulimit', ['-u']).toString().trim())
const currentSystemProcesses = parseInt(execSync('ps ax | wc -l'))
let currentApplicationProcesses = 0
const processBuffer = 25
const processLimit = systemProcessesLimit - currentSystemProcesses - processBuffer

main()

function main() {
  searchPackObjects()
}

function searchPackObjects() {
  console.time('<<< PACK OBJECT PROCESS >>>')
  console.log(`Finding pack objects larger than ${threshold / MiB} MiB...`)
  const packObjectProcess = spawn(gitPackObjectCmd, {shell: `${shellPath}`})
  packObjectProcess
    .stdout
    .on('data', data => {
      data
        .toString()
        .split('\n')
        .map(element => element.split(' ')
          .filter(element => element !== ''))
        .map(element => {
          const packHash = element[0]
          const compressed = element[3]
          if(compressed >= threshold) {
            console.log(packHash, compressed / MiB)
            packObjectPackSize.set(packHash, compressed)
          }
        })
    })
  packObjectProcess
  .on('exit', () => {
    console.timeEnd('<<< PACK OBJECT PROCESS >>>')
    searchCommits()
  })
}

function searchCommits() {
  console.time('<<< COMMIT LIST PROCESS >>>')
  console.log('Looking up commits...')
  const commitListProcess = spawn('git',  ['rev-list', '--all'])
  commitListProcess
    .stdout
    .pipe(split())
    .on('data', line => {
      commitQueue.enqueue(line.trim())
      queueCycle()
    })
  commitListProcess
    .stderr
    .on('data', data => {
      console.error(`${data}`)
    })

  commitListProcess
    .on('close', () => {
      console.timeEnd('<<< COMMIT LIST PROCESS >>>')
      console.log('Searching through commits...')
      console.time('<<< COMMIT TREE PROCESS >>>')
      Promise.all(commitTreeProcessPromises)
        .then(() => {
          console.timeEnd('<<< COMMIT TREE PROCESS >>>')
          renderOutput()
        })
    })
}

function spinUpCommitProcess(commitHash) {
  commitTreeProcessPromises.push(new Promise((resolve, reject) => {
    const commitTreeProcess = spawn('git', ['ls-tree', '-zlr', commitHash])
    commitTreeProcess
      .stdout
      .on('data', data => {
        data
          .toString()
          .split('\0')
          .filter(element => element !== '')
          .map(element => {
            const entry = element.split(' ').filter(element => element !== '')
            const blobHash = entry[2]
            if(packObjectPackSize.has(blobHash)) {
              if(entry[3]) {
                const subEntry = entry[3].split('\t')
                const uncompressed = (parseFloat(subEntry[0]) / MiB).toFixed(1)
                const compressed = (parseFloat(packObjectPackSize.get(blobHash)) / MiB).toFixed(1)
                const path = subEntry[1]
                bigFiles[`${blobHash}-${commitHash}`] = {
                  blobHash,
                  commitHash,
                  uncompressed,
                  compressed,
                  path
                }
              }
            }
          })
      })
    commitTreeProcess
      .on('close', () => {
        resolve()
        currentApplicationProcesses -= 1
      })
    commitTreeProcess
      .stderr
      .on('data', data => {
        reject(`${data}`)
      })
  }))
}

function queueCycle() {
  if(commitQueue.size() > 0) {
    if(currentApplicationProcesses < processLimit) {
      processQueue()
    }
    else {
      setImmediate(queueCycle)
    }
  }
}

function processQueue() {
  spinUpCommitProcess(commitQueue.dequeue())
  currentApplicationProcesses += 1
}

function renderOutput() {
  console.log('\nAll file sizes in MiB. Pack column is the compressed size of the object inside the pack file.\n')

  console.log(vsprintf('%-6s \%-6s \%-7s \%-50s \%s', ['[size]', '[pack]', '[blob]', '[commit]', '[path]']))
  console.log('')

  for(blob_commit_Hash in bigFiles) {
    const commitInfoFull = execFileSync('git', ['show', '-s', `${bigFiles[blob_commit_Hash].commitHash}`, '--format=%h: %ci-%s']).toString().trim()

    const commitInfoHash = commitInfoFull.substr(0,7)
    const commitInfoTime = commitInfoFull.split(' ')[1]
    const commitInfoSubject = commitInfoFull.split('-')[4]

    console.log(vsprintf('%-6s \%-6s \%-7s \%-50s \%s', [ bigFiles[blob_commit_Hash].uncompressed, bigFiles[blob_commit_Hash].compressed, bigFiles[blob_commit_Hash].blobHash.substr(0,7), `${commitInfoHash}: ${commitInfoTime} [${commitInfoSubject}]`, bigFiles[blob_commit_Hash].path ]))
  }
  console.timeEnd('<<< TOTAL PROCESS >>>')
}
