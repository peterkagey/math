# Mobius...
require_relative '../helpers/subset_logic'

# edges = [
#   [1, 2], [1, 4], [1, 0],
#   [3, 2], [3, 4], [3, 0],
#   [5, 2], [5, 4], [5, 0]
# ]

def edges(n)
  throw "requires even input" if n.odd?
  (0...n).flat_map do |i|
    [(i - 1) % n, (i + 1) % n, (i + (n/2)) % n]
      .select { |j| j > i }
      .map { |j| [i, j] }
  end
end

def leaf_free?(ns)
  ns.flatten.uniq.all? { |n| ns.count(n) != 1 }
end

x = edges(4).uniq.count_subsets do |subset|
  if leaf_free?(subset.flatten)
    p subset
    true
  end
end


# p edges(6).length
p x
