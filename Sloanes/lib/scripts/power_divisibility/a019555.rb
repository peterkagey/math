require_relative '../helpers/prime_factors'

class OEIS
  # Smallest number whose cube is divisible by n.
  def self.a019555(n)
    PrimeFactors.hash(n).collect { |b, k| b**(k/3.0).ceil }.reduce(:*) || 1
  end
end
