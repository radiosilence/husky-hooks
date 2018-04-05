#!/usr/bin/env node
import * as fs from 'fs'
const branch = require('git-branch')

// Get the filename for commit message
const name = process.argv[2]

// Take existing message in file and strip out empty/comments
const existing = fs
    .readFileSync(name, 'utf-8')
    .split('\n')
    .filter((line) => !line.trimLeft().startsWith('#'))
    .filter(Boolean)

if (existing.length === 0) {
    console.error('Aborting commit due to empty commit message.')
    process.exit(-1)
}

// Strip the words from the ticket
const branchName = branch.sync()

let prefix = ''

if (
    typeof branchName === 'string' &&
    branchName.match(/^[A-Z]{3}-[0-9]{1,4}/)
) {
    const ticket = branchName.split('_')[0]
    prefix = `[${ticket}] `
}

// Prepend the shortened branch name
fs.writeFileSync(name, `${prefix}${existing.join('\n')}`)
