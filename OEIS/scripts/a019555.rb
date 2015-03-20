require_relative 'helpers/prime_factors_hash'

class OEIS
  def self.a019555(n)
    # Smallest number whose cube is divisible by n.
    prime_factors(n).collect { |b, k| b**(k/3.0).ceil }.reduce(:*) || 1
  end
end
