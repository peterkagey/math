require_relative 'prime_factor_hash'

class OEIS
  def self.a000188(n)
    # Max k such that k^2|n.
    prime_factors(n).collect { |prime, power| prime**(power/2) }.reduce(:*) || 1
  end
end
