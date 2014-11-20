# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see 
# that the 6th prime is 13.
# What is the 10 001st prime number?
require File.join File.dirname(__FILE__),'function_sieve_of_eratosthenes'

start = Time.now

p sieve_of_eratosthenes(2000000).reduce(:+)
p Time.now - start

# 142913828922
# 0.856559 seconds