require_relative '../helpers/alec_sequences'

class A999997Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :max, e = 0, seed) { |a_i, n, i| a_i % i == n % i }
  end
end

class OEIS
  @@a999997 = A999997Builder.sequence(1, [0])

  def self.a999997(n)
    raise "A999997 is not defined for n = #{n} < 1" if n < 1
    @@a999997 = A999997Builder.sequence(n, @@a999997)
    @@a999997[n - 1]
  end
end

# a(1) = 0, then a(n) is the maximum of all 0 < m < n for which n == a(m) (mod m).

# a(1) = 1 by definition
# a(2) = 1 because a(1) == 2 (mod 1)
# a(3) = 2 because a(2) == 3 (mod 2)
# a(4) = 1 because a(1) == 4 (mod 1)
# a(5) = 4 because a(4) == 5 (mod 4)
# a(6) = 1 because a(1) == 6 (mod 1)
# a(7) = 6 because a(6) == 7 (mod 6)
# a(8) = 3 because a(3) == 8 (mod 3)

# 0, 1, 2, 1, 4, 1, 6, 3, 5, 1, 10, 1, 12, 9, 2, 1, 16, 1, 18, 7, 11, 1, 22, 5, 13, 3, 20, 1, 28, 1, 30, 21, 17, 7, 8, 1, 36, 25, 5, 1, 40, 1, 42, 39, 23, 1, 46, 7, 16, 33, 14, 1, 52, 11, 48, 19, 29, 1, 58, 1, 60, 15, 38, 13, 54, 1, 66, 45, 7, 1, 70, 1, 72, 27

# Cf. A269423, A269427, A271530, A271531.
