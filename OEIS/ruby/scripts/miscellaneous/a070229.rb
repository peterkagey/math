require_relative '../helpers/prime_factors_hash'
require_relative '../helpers/b_file_to_hash'

class OEIS
  # Next m>n such that m is divisible by the greatest prime factor of n (A006530(n)).
  def self.a070229(n)
    k = prime_factors(n).select { |_,v| v > 0 }
    n + (k.keys.max || 1)
  end
end


