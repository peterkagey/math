# It was proposed by Christian Goldbach that every odd composite number can be
# written as the sum of a prime and twice a square.

# 9 = 7 + 2×12
# 15 = 7 + 2×22
# 21 = 3 + 2×32
# 25 = 7 + 2×32
# 27 = 19 + 2×22
# 33 = 31 + 2×12

# It turns out that the conjecture was false.

# What is the smallest odd composite that cannot be written as the sum of a 
# prime and twice a square?

start = Time.now

require_relative '../function/sieve_of_eratosthenes'

primes = sieve_of_eratosthenes(10**4)[1..-1]

def is_square?(k)
	s = Math.sqrt(k)
	s == s.to_i
end

def goldbach(n, odd_primes)
	odd_primes.each do |p|
		break if p > n
		return true if is_square?((n - p)/2)
	end
	return false
end

i = 9
loop do
	break unless goldbach(i, primes)
	i += 2
end

p i
p Time.now - start

# 5777
# 0.087212 seconds
# I don't love that finding this solution depends on the size of the sieve.