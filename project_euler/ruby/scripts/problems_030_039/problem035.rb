# The number, 197, is called a circular prime because all rotations of the
# digits: 197, 971, and 719, are themselves prime.

# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37,
# 71, 73, 79, and 97.

# How many circular primes are there below one million?

start = Time.now

require_relative '../function/sieve_of_eratosthenes'

def rotate(i)
  return i if i < 10
  (i.to_s[1..-1] + i.to_s[0]).to_i
end

primes = sieve_of_eratosthenes(10**6)
6.times{ primes = primes & primes.collect{ |x| rotate(x) } }
p primes.length
p Time.now - start

# 55
# 0.356699

# One of my most elegant solutions.
