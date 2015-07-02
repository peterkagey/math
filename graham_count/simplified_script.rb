require_relative '../OEIS/scripts/a248663'
require_relative '../OEIS/scripts/a006255'
class Array

  def count_subsets(&block)
    counter = 0
    each_subset { |i| counter += 1 if yield(i) }
    counter
  end

  def each_subset(&block)
    (0...2**length).each { |i| yield(subset(i)) }
  end

  private
  # [1,2,3].subset(0b0)   => []
  # [1,2,3].subset(0b1)   => [1]
  # [1,2,3].subset(0b10)  => [2]
  # [1,2,3].subset(0b11)  => [1,2]
  # [1,2,3].subset(0b100) => [3]
  # [1,2,3].subset(0b101) => [1,3]
  # [1,2,3].subset(0b110) => [2,3]
  # [1,2,3].subset(0b111) => [1,2,3]
  def subset(index)
    sub_array = []
    (0...index.bit_length).each { |j| sub_array << self[j] if index[j] == 1 }
    sub_array
  end

end

def g(n); OEIS.a006255(n) end
def h(n); OEIS.a248663(n) end

# Because g(n) <= 2n for all n > 3, prime values will never contribute to a
# valid sequence, thus they can be thrown out.
def middle_terms(n)
  all_terms = (n+1...g(n)).to_a
  n < 4 ? all_terms : all_terms.select { |i| !Prime.prime?(i) }
end

# Let S = {n = a_0, a_1, a_2, ..., a_t = g(n)}.
# The product of S is a perfect square if and only if
# h(a_0) ^ h(a_1) ^ ... ^ h(a_t) == 0
def perfect_square?(sequence)
  sequence.map{ |i| h(i) }.reduce(:^) == 0
end

# We want to count all subsets whose product is a perfect square.
def a(n)
  middle_terms(n).count_subsets { |subset| perfect_square?([n, g(n)] + subset) }
end

p a(ARGV[0].to_i)
