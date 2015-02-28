require_relative 'helpers/prime_factors_hash'

class OEIS
  def self.a254767(n, h = 3)
    # a(n) is the least k > n such that k*n is a perfect cube.
    prime_factors(n).collect { |prime, k| prime**(-k % h) }.reduce(:*) || 1
  end
end

# def a(n)
#   min = (n**(2/3.0)).ceil
#   (min..n+1).each { |i| return i**3/n if i**3 % n == 0 && i**3 > n**2 }
# end
