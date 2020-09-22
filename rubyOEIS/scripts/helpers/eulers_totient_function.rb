require_relative 'prime_factors'

def phi(n)
  PrimeFactors.hash(n).map { |p, k| k > 0 ? p**(k-1)*(p-1) : 1 }.reduce(:*) || 1
end
