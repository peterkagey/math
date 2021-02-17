def cannonical_necklace(seq)
  raise "Invalid sequence" unless seq.first == 1 && seq.last == 1
  necklaces = [seq]
  (2...seq.count(1)).each { necklaces << rotate(necklaces.last) }
  necklaces += necklaces.map { |i| i.reverse }
  necklaces.sort.first
end

def rotate(seq)
  index_of_second_1 = (1...seq.length).find { |i| seq[i] == 1 }
  seq[index_of_second_1..-1] + seq[1..index_of_second_1 - 1] + [1]
end

p x.group_by { |n| cannonical_necklace(n) }
