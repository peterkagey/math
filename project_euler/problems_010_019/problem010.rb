# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# Find the sum of all of the primes below two million.

start = Time.now
require_relative '../function/sieve_of_eratosthenes'

p sieve_of_eratosthenes(2000000).reduce(:+)
p Time.now - start

# 142913828922
# 0.471795 seconds