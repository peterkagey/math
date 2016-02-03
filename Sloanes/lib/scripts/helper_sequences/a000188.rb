require_relative '../helpers/prime_factors'

class OEIS

  # (1) Number of solutions to x^2 = 0 (mod n). (2) Also square root of largest
  # square dividing n. (3) Also Max_{ d divides n } GCD(d, n/d).
  def self.a000188(n)
    # Max k such that k^2|n.
    PrimeFactors.hash(n).collect { |prime, power| prime**(power/2) }.reduce(:*) || 1
  end
end
