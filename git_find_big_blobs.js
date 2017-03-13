#!/usr/local/bin/Node

const exec = require('child_process').exec
const spawn = require('child_process').spawn
const readline = require('readline')
const fs = require('fs')

const git_commit_list_cmd = 'git rev-list --all'

const rev = spawn('git rev-list');

rev.stdout.on('data', (data) => {
  console.log(`stdout: ${data}`);
})

  // const revs = stdout
  // const rl = readline.createInterface({
  //   input: fs.createReadStream(revs)
  // })
  // rl.on('line', (line) => {
  //   console.log(`${line}`)
  // })




// IO.popen(git_commit_list_cmd) do | commits |
//     commits.each_line do | commitHash |
//       commitHash.chomp!
//       puts `git ls-tree -zlr #{commitHash}`
//       for blob in `git ls-tree -zlr #{commitHash}`.split("\0")
//         blobHash = blob.split[2]
//         if pack_object_pack_size.has_key? blobHash
//           path = blob.split[4]
//           uncompressed = blob.split[3].to_f
//           compressed = pack_object_pack_size[blobHash]
//           big_files[blobHash] = [uncompressed, compressed, commitHash, path]
//         end
//       end
//     end
//   end

// arg = process.argv[2]
// const Megabyte = 1024
// const threshold = (arg || 0.1) * Megabyte



// exec('git rev-parse --git-dir', (error, stdout, stderr) => {
//   if (error) {
//     console.error(`exec error: ${error}`);
//     return;
//   }
//   return stdout
// });

// const git_pack_object_cmd = `git verify-pack -v ${git_dir}/objects/pack/pack-*.idx | rg blob`
// const git_commit_list_cmd = "git rev-list --all"

// const packObj = spawn(git_pack_object_cmd)
// const git_dir_cmd = 'git rev-parse --git-dir'
// const rl = readline.createInterface({
//   input: fs.createReadStream(`git_dir_cmd`)
// })

// rl.on('line', (line) => {
//   console.log(`${line}`)
// })
