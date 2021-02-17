# Alec's tau function
# Given h players on a nxn board, what is the greatest number of k-in-a-row that can occur?
# o x x x }
# o o x x } has 8 3-in-a-rows (if I counted correctly).
# o o x x }
# o o o x }

def tuples(n)
  (0...n).flat_map { |i| (0...n).map { |j| [i, j] } }
end

tuples(3).combination(4)

def pairs(tuple, ary_of_tuples)
  a, b = tuple
  neighboring_distances = [1, 0, -1]
  -1 + ary_of_tuples.count do |x|
    neighboring_distances.include?(a - x.first) &&
    neighboring_distances.include?(b - x.last)
  end
end

def total_count(ary_of_tuples)
  ary_of_tuples.map { |tuple| pairs(tuple, ary_of_tuples) }.reduce(:+)/2
end

require 'set'

def counts(n)
  s = SortedSet.new
  t = tuples(n)
  t.combination(n**2/2).each do |ary_of_tuples|
    x = total_count(ary_of_tuples) - total_count(t - ary_of_tuples)
    p x, ary_of_tuples if !s.include?(x)
    s << x
  end
  s

end

# p counts(2)
# p counts(3)
# p counts(4)
p counts(5)
# p counts(10)

# p tuples(3).combination(4).group_by { |ary_of_tuples| total_count(ary_of_tuples) + total_count(tuples(3) - ary_of_tuples) }
# p tuples(4).combination(8).group_by { |ary_of_tuples| total_count(ary_of_tuples) + total_count(tuples(3) - ary_of_tuples) }.keys.sort
