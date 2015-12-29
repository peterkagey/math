require_relative 'prime_factors_hash'

def phi(n)
  prime_factors(n).map { |p, k| k > 0 ? p**(k-1)*(p-1) : 1 }.reduce(:*) || 1
end
