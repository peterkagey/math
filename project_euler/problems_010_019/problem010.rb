# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see 
# that the 6th prime is 13.
# What is the 10 001st prime number?

start = Time.now

require_relative '../function/sieve_of_eratosthenes'

p sieve_of_eratosthenes(2000000).reduce(:+)
p Time.now - start

# 142913828922
# 0.471795 seconds