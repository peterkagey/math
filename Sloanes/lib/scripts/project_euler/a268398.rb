require_relative 'a085731'
require_relative '../helpers/sums_and_differences'

# The solution to Project Euler Problem 484: Arithmetic Derivative
# is a(5*10^15) - 1
# https://projecteuler.net/problem=484

class A268398Builder
  def self.sequence(terms = 100)
    (1..terms).map { |i| OEIS.a085731(i) }.cumulative_sum
  end
end

class OEIS
  A268398_SEQUENCE = A268398Builder.sequence
  def self.a268398(n)
    raise "A268398 is not defined for n = #{n}" if n < 1
    A268398_SEQUENCE[n - 1] || A268398Builder.sequence(n).last
  end
end

