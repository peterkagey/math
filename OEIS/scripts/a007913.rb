require_relative 'prime_factor_hash'

class OEIS
  def self.a007913(n)
    # squarefree part of n
    prime_factors(n).select { |prime, power| power.odd? }.keys.reduce(:*) || 1
  end
end
