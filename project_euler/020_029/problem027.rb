# Euler discovered the remarkable quadratic formula:

# n² + n + 41

# It turns out that the formula will produce 40 primes for the consecutive 
# values n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is 
# divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly 
# divisible by 41.

# The incredible formula  n² − 79n + 1601 was discovered, which produces 80 
# primes for the consecutive values n = 0 to 79. The product of the 
# coefficients, −79 and 1601, is −126479.

# Considering quadratics of the form:

# n² + an + b, where |a| < 1000 and |b| < 1000

# where |n| is the modulus/absolute value of n
# e.g. |11| = 11 and |−4| = 4
# Find the product of the coefficients, a and b, for the quadratic expression 
# that produces the maximum number of primes for consecutive values of n, 
# starting with n = 0.

###############################################
# NOTICE: b must be prime, and a must be odd! #
###############################################
start = Time.now

require_relative '../function/sieve_of_eratosthenes'

primes = sieve_of_eratosthenes(10000)

a_candidates = (-498..499).collect{|x| 2*x -1}
b_candidates = sieve_of_eratosthenes(1000)
def f(a,b,n); n*n + a*n + b end

h = {}
max_val = 0

b_candidates.reverse.each do |b|
	break if b < h.values.max.to_i
	a_candidates.each do |a|
		n = 0
		loop do
			n += 1
			if !primes.include?(f(a,b,n))
				if n > max_val
					max_val = n
					h[a*b] = n
				end
				break
			end
		end
	end
end

p h.key(h.values.max)
p Time.now - start

# -59231
# 6.180627 seconds