#!/usr/local/bin ruby -w
arg = ARGV[0]
MiB = 1024 ** 2
threshold = (arg.to_f || 0.1) * MiB

big_files = {}

git_dir_cmd = "git rev-parse --git-dir"
git_dir = IO.popen(git_dir_cmd).readline.chomp

packed_objects = "git verify-pack -v #{git_dir}/objects/pack/pack-*.idx | rg -e '(blob|commit)' | sort -k4nr"
unpacked_objects = "git rev-list --all --objects"

IO.popen(packed_objects) do | pack_objects |
  pack_objects.each_line do | pack_object |
    type = pack_object.split[1]
    hash = pack_object.split[0]
    if type == "blob"
      uncompressed = pack_object.split[2]
      compressed = pack_object.split[3]
      hash_path = `#{unpacked_objects} | rg #{hash}`
      path = hash_path.split[1]
    elsif type == "commit"
      puts "<<< #{hash} >>>"
      a = `git ls-tree -zrl #{hash}`.split("\0")
      b = a.split[3]

      puts b
      c = `git show -s #{hash} --format='%h: %cr'`.chomp
      commit = c
    end
    warn "Another path for #{hash} is #{path}" if big_files.has_key? hash and big_files[hash][0] != path
    big_files[hash] = [uncompressed, compressed, commit, path] if compressed.to_i >= threshold
  end
end

def formatStringNumber stringNumber
   (stringNumber.to_f / MiB).round(1).to_s
end

puts "\nAll file sizes in MiB. Pack column is the compressed size of the object inside the pack file."

# Column headers
puts "\n%-7s \%-7s \%-8s \%-21s \%s" % ["[size]", "[pack]", "[hash]", "[commit]", "[path]"]
puts

big_files.each do | hash, (uncompressed, compressed, commit, path) |
  puts "%-7s \%-7s \%-8s \%-21s \ %s" % [ formatStringNumber(uncompressed), formatStringNumber(compressed), hash[0...7], commit, path]
end
