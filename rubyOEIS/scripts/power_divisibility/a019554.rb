require_relative '../helpers/prime_factors'

class OEIS
  # Smallest number whose cube is divisible by n.
  def self.a019554(n)
    PrimeFactors.hash(n).map { |b, k| b**(k/2.0).ceil }.reduce(:*) || 1
  end
end
