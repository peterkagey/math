require 'open-uri'

def web_contents(id)
  id = "#{id}".rjust(6, '0')
  url = "https://oeis.org/A#{id}/b#{id}.txt"
  open(url) { |f| f.read }
end

def text_to_hash(id)
  text = web_contents(id)
  rows = text.split("\n").reject { |str| str[0] == "#" }
  Hash[rows.collect { |str| str.split(" ").map(&:to_i) }]
end

