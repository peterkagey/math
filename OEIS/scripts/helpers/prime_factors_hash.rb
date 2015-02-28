require 'prime'

def prime_factors(n) # prime_factors(20) = { 2=>2, 3=>0, 5=>1}
  factors_hash = {}
  Prime.each do |q|
    break if n == 1
    factors_hash[q] = 0
    while n % q == 0
      n /= q
      factors_hash[q] += 1
    end
  end
  factors_hash
end
