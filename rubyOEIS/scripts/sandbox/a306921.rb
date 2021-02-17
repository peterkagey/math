load '/Users/pk/personal/math/Sloanes/lib/scripts/helpers/subset_logic.rb'

def all_substrings(n)
  s = n.to_s(2)
  (1...s.length).to_a
    .map_subsets { |is| split_along_indices(s, is) }
end

def all_numeric_substrings(n)
  all_substrings(n)
    .select { |part| part.all? { |x| x =~ /(^1)|^0$/} }
end

def a306921(n)
  all_numeric_substrings(n).length
end

def a306922(n)
  all_numeric_substrings(n)
    .map { |ps| ps.map { |x| x.to_i(2) }.reduce(:+) }
    .uniq
    .count { |i| is_power_of_two?(i) }
end

def split_along_indices(string, indices)
  pairs([0, indices, 0].flatten)
    .map { |s, e| string[s..e-1]}
end

def pairs(a)
  a[0...-1].zip(a[1..-1])
end

def is_power_of_two?(i)
  return true if i == 1
  return false if i % 2 == 1
  is_power_of_two?(i/2)
end

n = 15
x = (1..2**n + 2).map { |i| a306921(i) }
p (1..n + 1).map { |i| x.count(i) }

# p all_numeric_substrings(9)
