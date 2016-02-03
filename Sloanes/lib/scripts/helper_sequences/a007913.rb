require_relative '../helpers/prime_factors'

class OEIS

  # Squarefree part of n: a(n) = smallest positive number m such that n/m is a
  # square.
  def self.a007913(n)
    PrimeFactors.hash(n).select { |prime, power| power.odd? }.keys.reduce(:*) || 1
  end

end
