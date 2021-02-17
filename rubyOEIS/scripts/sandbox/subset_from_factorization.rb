require 'prime'

class Array
  # This takes an array, adds the reciprocals, and takes the (reduced-form) numerator.
  def inverse_num
    inject(0) { |accum, i| accum + Rational(1)/Rational(i) }.numerator
  end

  # This takes an array, adds the reciprocals, and takes the (reduced-form) denominator.
  def inverse_denom
    inject(0) { |accum, i| accum + Rational(1)/Rational(i) }.denominator
  end
end

# A112798
def one_indexed_factorization_subset(n)
  collection = []
  Prime.each_with_index do |prime, index|
    return collection if n < prime
    while n % prime == 0
      collection << index + 1
      n /= prime
    end
  end
end

# p (1..30).flat_map { |i| one_indexed_factorization_subset(i) } # A112798
# p (1..30).map { |i| one_indexed_factorization_subset(i).max } # A061395
# p (1..30).map { |i| one_indexed_factorization_subset(i).min } # A055396
# p (1..30).map { |i| one_indexed_factorization_subset(i).length } # A001222
# p (1..30).map { |i| one_indexed_factorization_subset(i).reduce(1, :*) } # A003963
# p (1..30).map { |i| one_indexed_factorization_subset(i).reduce(0, :+) } # A056239

# p (1..30).map { |i| one_indexed_factorization_subset(i).reduce(1, :lcm) }
# p (1..30).map { |i| one_indexed_factorization_subset(i).reduce(0, :gcd) }
# p (1..30).map { |i| one_indexed_factorization_subset(i).inverse_num }
# p (1..30).map { |i| one_indexed_factorization_subset(i).inverse_denom }
