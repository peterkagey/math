require 'prime'
require_relative 'prime_factors_hash'

class OEIS
  def self.a248663(n)
    factors = prime_factors(n).sort.reverse
    m = 0
    factors.each { |prime_power_ary| m <<= 1; m += prime_power_ary[1] % 2 }
    m
  end
end
