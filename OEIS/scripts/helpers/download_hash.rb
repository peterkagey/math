require 'open-uri'

def web_contents(id)
  id = "#{id}".rjust(6, '0')
  url = "https://oeis.org/A#{id}/b#{id}.txt"
  open(url) { |f| f.read }
end

# A000040 is the prime numbers
# seq_to_hash(40)
# >> {0=>2, 1=>3, 2=>5, ... }
def seq_to_hash(id)
  text = web_contents(id)
  rows = text.split("\n").reject { |str| str[0] == "#" }
  Hash[rows.collect { |str| str.split(" ").map(&:to_i) }]
end
