# The prime factors of 13195 are 5, 7, 13 and 29.

# What is the largest prime factor of the number 600851475143 ?

start = Time.now
require_relative '../function/sieve_of_eratosthenes'

a = 600851475143
n = 4
primes = sieve_of_eratosthenes(10**n)

primes.each do |p|
	loop do; (a % p == 0 ? a /= p : break) end	
	(p p; break) if a == 1
end

if a != 1 											# Safeguard in the case
	c = 10**n 										# that n is too small
	loop do                                         #
		loop do; (a % c == 0 ? a /= c : break) end	#
		(p c; break) if a == 1 						#
		c += 1 										#
	end 											#
end	                                                #


p Time.now-start
# 6857
# 0.002216 seconds

