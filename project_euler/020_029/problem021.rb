# Let d(n) be defined as the sum of proper divisors of n (numbers less than n 
# which divide evenly into n).
# If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and 
# each of a and b are called amicable numbers.

# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 
# 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 
# 71 and 142; so d(284) = 220.

# Evaluate the sum of all the amicable numbers under 10000.

start = Time.now

require_relative '../function/sieve_of_eratosthenes'
require_relative '../function/prime_factors'
require_relative '../function/proper_factor_sum'

primes = sieve_of_eratosthenes(10000)

h = Hash.new(0)
for i in (2...10000) do
	h[i] = proper_factor_sum(i, primes)
end

p h.keys.select{ |k| h[h[k]] == k && h[k] != k }.reduce(:+)
p Time.now - start

# 31626
# 0.604285 seconds