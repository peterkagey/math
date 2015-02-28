require 'prime'

def prime_factors(n) # prime_factors(20) = { 2=>2, 3=>0, 5=>1}
  factors_hash = Hash.new(0)
  Prime.each do |q|
    break if n == 1
    factors_hash[q] = factors_hash[q]
    while n % q == 0
      n /= q
      factors_hash[q] += 1
    end
  end
  factors_hash
end
