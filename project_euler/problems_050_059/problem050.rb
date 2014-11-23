# The prime 41, can be written as the sum of six consecutive primes:

# 41 = 2 + 3 + 5 + 7 + 11 + 13
# This is the longest sum of consecutive primes that adds to a prime below 
# one-hundred.

# The longest sum of consecutive primes below one-thousand that adds to a 
# prime, contains 21 terms, and is equal to 953.

# Which prime, below one-million, can be written as the sum of the most 
# consecutive primes?

start = Time.now

require_relative '../function/sieve_of_eratosthenes'

primes = sieve_of_eratosthenes(10**6)

def prime_sum(start_i, break_val, n, primes)
    p_sum = (start_i...start_i + n).collect{ |i| primes[i] }.reduce(:+)
    return if p_sum > break_val # if the prime sum gets too big, stop.
    i = start_i + n 			# otherwise start here
    candidate_terms = []		# will collect a hash of the last prime and 
    loop do
        p_sum += primes[i] 			# add on next prime
        break if p_sum > break_val 	# the sum has gotten above one-million
        candidate_terms << p_sum    # later: test this to determine if it contains primes
        i += 1 						
    end
    prime_candidates = candidate_terms & primes
    return [0, 0] if prime_candidates == []	# no primes in list
    number_of_terms = candidate_terms.index(prime_candidates.max) + n + 1
    return [number_of_terms, prime_candidates.last]
end

number_of_terms = 1
new_max = 953
primes.each_with_index do |p,i|
	ps = prime_sum(i, 10**6, number_of_terms, primes) 	# First pass is slow
	break if ps.nil? 				   					# initial sum is too large
	# update if there is a new best. 
	(number_of_terms = ps[0]; new_max = ps[1]) if ps[0] > number_of_terms
end

p new_max
p Time.now - start

# 997651
# 0.353375 seconds