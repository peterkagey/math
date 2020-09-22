require_relative '../helpers/prime_factors'

class OEIS

  # Next m>n such that m is divisible by the greatest prime factor of n (A006530(n)).
  def self.a070229(n)
    k = PrimeFactors.hash(n).select { |_,v| v > 0 }
    n + (k.keys.max || 1)
  end

end
