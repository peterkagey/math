require File.join File.dirname(__FILE__),'function_sieve_of_eratosthenes'
require File.join File.dirname(__FILE__),'function_prime_factors'
require File.join File.dirname(__FILE__),'function_proper_factor_sum'
start = Time.now

primes = sieve_of_eratosthenes(10000)

h = Hash.new(0)
for i in (2...10000) do
	h[i] = proper_factor_sum(i, primes)
end

p h.keys.select{ |k| h[h[k]] == k && h[k] != k }.reduce(:+)
p Time.now - start

# 31626
# 0.604285 seconds