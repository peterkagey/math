require_relative '../helpers/prime_factors'

class OEIS
  # Smallest k > 0 such that n*k is a perfect cube.
  def self.a048798(n, h = 3)
    PrimeFactors.hash(n).map { |prime, k| prime**(-k % h) }.reduce(:*) || 1
  end

end
