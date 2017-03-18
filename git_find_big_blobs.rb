#!/usr/local/bin ruby -w

args = ARGV
MiB = 1024 ** 2
$limit = 50
for arg in args
  $limit = arg if Float(arg) != nil rescue false
end
$threshold = $limit.to_f * MiB

def formatStringNumber stringNumber
   (stringNumber.to_f / MiB).round(1).to_s
end

def commits
  pack_object_pack_size = {}
  big_files = {}

  git_dir_cmd = "git rev-parse --git-dir"
  git_dir = IO.popen(git_dir_cmd).readline.chomp

  git_pack_object_cmd = "git verify-pack -v #{git_dir}/objects/pack/pack-*.idx | rg blob"
  git_commit_list_cmd = "git rev-list --all"

  puts "Finding pack objects larger than #{$limit} MiB..."
  IO.popen(git_pack_object_cmd) do | pack_objects |
    pack_objects.each_line do | pack_object |
      packHash = pack_object.split[0]
      compressed = pack_object.split[3].to_f
      pack_object_pack_size[packHash] = compressed if compressed >= $threshold
    end
  end

  puts "Searching commits..."
  IO.popen(git_commit_list_cmd) do | commits |
    commits.each_line do | commitHash |
      commitHash.chomp!
      for blob in `git ls-tree -zlr ae0cddd9f4e75959d75fd1d5b2f251ae70450f61`.split("\0")
        puts blob
        blobHash = blob.split[2]
        if pack_object_pack_size.has_key? blobHash
          path = blob.split[4]
          uncompressed = blob.split[3].to_f
          compressed = pack_object_pack_size[blobHash]
          big_files[blobHash] = [uncompressed, compressed, commitHash, path]
        end
      end
    end
  end

  puts "\nAll file sizes in MiB. Pack column is the compressed size of the object inside the pack file."

  # Column headers
  puts "\n%-7s \%-7s \%-8s \%-33s \%s" % ["[size]", "[pack]", "[blob]", "[commit]", "[path]"]
  puts

  big_files.each do | blobHash, (uncompressed, compressed, commitHash, path) |
    commitInfo = `git show -s #{commitHash} --format='%h: %cr'`.chomp
    puts "%-7s \%-7s \%-8s \%-33s \%s" % [ formatStringNumber(uncompressed), formatStringNumber(compressed), blobHash[0...7], commitInfo, path]
  end
end

def noCommits
  paths = {}
  big_files = {}

  git_dir_cmd = "git rev-parse --git-dir"
  git_dir = IO.popen(git_dir_cmd).readline.chomp

  git_pack_object_cmd = "git verify-pack -v #{git_dir}/objects/pack/pack-*.idx | rg blob | sort -k4nr"
  git_unpacked_object_cmd = "git rev-list --all --objects | awk '$2'"

  puts "Finding pack object paths..."
  IO.popen(git_unpacked_object_cmd) do | unpacked_objects |
    unpacked_objects.each_line do | unpacked_object |
      rev_hash = unpacked_object.split[0]
      path = unpacked_object.split[1]
      paths[rev_hash] = path
    end
  end

  puts "Finding pack objects larger than #{$limit} MiB..."
  IO.popen(git_pack_object_cmd) do | pack_objects |
    pack_objects.each_line do | pack_object |
      packHash = pack_object.split[0]
      uncompressed = pack_object.split[2]
      compressed = pack_object.split[3].to_f
      path = paths[packHash]
      big_files[packHash] = [uncompressed, compressed, path] if compressed >= $threshold
    end
  end

  puts "\nAll file sizes in MiB. Pack column is the compressed size of the object inside the pack file."

  # Column headers
  puts "\n%-7s \%-7s \%-8s \%s" % ["[size]", "[pack]", "[blob]", "[path]"]
  puts

  big_files.each do | blobHash, (uncompressed, compressed, path) |
    puts "%-7s \%-7s \%-8s \%s" % [ formatStringNumber(uncompressed), formatStringNumber(compressed), blobHash[0...7], path]
  end
end

if args.include? '-c'
  commits()
else
  noCommits()
end
