require_relative '../helpers/prime_factors_hash'

class OEIS

  def self.a005117(n)
    return 1 if n == 1
    last = a005117(n-1)
    (last + 1..last + 10).find { |i| prime_factors(i).values.max < 2 }
  end

end
