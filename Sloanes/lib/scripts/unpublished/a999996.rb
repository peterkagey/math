require_relative '../helpers/alec_sequences'

class A999996Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :max, e = 0, seed) { |a_i, n| n % a_i == 0 }
  end
end

class OEIS
  @@a999996 = A999996Builder.sequence(1, [1])

  def self.a999996(n)
    raise "A999996 is not defined for n = #{n} < 1" if n < 1
    @@a999996 = A999996Builder.sequence(n, @@a999996)
    @@a999996[n - 1]
  end
end

# a(1) = 1, then a(n) is the maximum of all 0 < m < n for which a(m) divides n.

# a(1) = 1 by definition
# a(2) = 1 because a(1) divides 2
# a(3) = 2 because a(2) divides 3
# a(4) = 3 because a(3) divides 4
# a(5) = 2 because a(2) divides 5
# a(6) = 5 because a(5) divides 6
# a(7) = 2 because a(2) divides 7
# a(8) = 7 because a(7) divides 8

# 1, 1, 2, 3, 2, 5, 2, 7, 4, 7, 2, 11, 2, 13, 6, 13, 2, 17, 2, 19, 10, 19, 2, 23, 6, 23, 4, 27, 2, 29, 2, 31, 12, 31, 10, 33, 2, 37, 16, 37, 2, 41, 2, 43, 6, 43, 2, 47, 10, 49, 18, 47, 2, 53, 12, 53, 22, 53, 2, 59, 2, 61, 10, 61, 16, 61, 2, 67, 26, 67, 2, 71, 2
# Cf. A088167, A269347, A271503, A271504.
