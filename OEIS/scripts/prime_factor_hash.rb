require 'prime'

def prime_factors(n) # prime_factors(12) = { 2=>2, 3=>1 }
  factors_hash = {}
  Prime.each do |q|
    factors_hash[q] = 0
    (n /= q; factors_hash[q] += 1) while n % q == 0
    break if n == 1
  end
  factors_hash
end
