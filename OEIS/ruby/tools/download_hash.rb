require 'open-uri'

def official_b_file(id)
  id = "#{id}"[/\d+/].rjust(6, '0')
  url = "https://oeis.org/A#{id}/b#{id}.txt"
  open(url) { |f| f.read }
end

def local_b_file(id)
  id = "#{id}"[/\d+/].rjust(6, '0')
  File.read(BFilePathIterator.number_to_path(id))
end

# A000040 is the prime numbers
# official_b_file_hash(40)
# >> {0=>2, 1=>3, 2=>5, ... }
def b_file_hash(b_file)
  rows = b_file.split("\n").reject { |str| str[0] == "#" }
  raise "No b-file for #{id}!" if rows == []
  Hash[rows.collect { |str| str.split(" ").map(&:to_i) }]
end

def official_b_file_hash(id)
  b_file_hash official_b_file(id)
end

def local_b_file_hash(id)
  b_file_hash local_b_file(id)
end
