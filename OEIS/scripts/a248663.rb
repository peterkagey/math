require 'prime'
require_relative 'helpers/prime_factors_hash'

class OEIS

  # a(A000040(n)) = 2^(n-1), and a(n*m) = a(n) XOR a(m).
  def self.a248663(n)
    factors = prime_factors(n).sort.reverse
    m = 0
    factors.each do |prime_power_ary|
      m <<= 1
      m += prime_power_ary[1] % 2
    end
    m
  end
end
