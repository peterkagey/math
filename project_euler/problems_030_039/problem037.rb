# # The number 3797 has an interesting property. Being prime itself, it is 
# # possible to continuously remove digits from left to right, and remain prime 
# # at each stage: 3797, 797, 97, and 7. Similarly we can work from right to 
# # left: 3797, 379, 37, and 3.

# # Find the sum of the only eleven primes that are both truncatable from left 
# # to right and right to left.

# # NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

start = Time.now

require_relative '../function/sieve_of_eratosthenes'

primes = sieve_of_eratosthenes(10**3)

def is_prime?(p, primes_ary)
	p = p.to_i
	return primes_ary.include?(p) if p < primes_ary[-1]
	(2..Math.sqrt(p)).each { |i| return false if p % i == 0 }
	return true
end

def left_trunc?(p, primes_ary) # can remove left digits
	(0...p.to_s.length).each do |l|
		return false unless is_prime?(p.to_s[l..-1], primes_ary)
	end
	return true
end

def right_trunc?(p, primes_ary) # can remove right digits
	(0...p.to_s.length-1).each do |r|
		return false unless is_prime?(p.to_s[0..r], primes_ary)
	end
	return true
end

# middle digits odd
# last digit odd prime

primes_list = []
candidates = [3,5,7]

loop do
	candidates.collect! do |p|
		[1,2,3,5,7,9].collect{|q| q.to_s + p.to_s}
	end
	candidates = candidates.flatten.map(&:to_i)
	primes_list += candidates.select!{|x| left_trunc?(x, primes)}
	pl = primes_list.select{|x| right_trunc?(x, primes)}
	break if pl.length == 11
end


p primes_list.sort.select{|x| right_trunc?(x, primes)}.reduce(:+)
p Time.now - start

# 748317
# 0.010781 seconds

# it's not pithy; right_trunc/left_trunc isn't DRY
# but it's pretty quick!