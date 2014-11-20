# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see 
# that the 6th prime is 13.
# What is the 10 001st prime number?

start = Time.now

require File.join File.dirname(__FILE__),'function_sieve_of_eratosthenes'

def log(n)
	Math.log(n)
end

def first_n_primes(n)
	k = 67 if n < 20
	k ||= (n * (log(n) + log(log(n)) - 0.5)).ceil
	sieve_of_eratosthenes(k)[0...n]
end

p first_n_primes(10001)[-1]
p Time.now - start


# 104743
# 0.055475 seconds