# The first two consecutive numbers to have two distinct prime factors are:

# 14 = 2 × 7
# 15 = 3 × 5

# The first three consecutive numbers to have three distinct prime factors
# are:

# 644 = 2² × 7 × 23
# 645 = 3 × 5 × 43
# 646 = 2 × 17 × 19.

# Find the first four consecutive integers to have four distinct prime
# factors. What is the first of these numbers?

start = Time.now

def sieve(n) # primes greater than n/2 don't get marked (but that's okay!)
	bool_arry = [0, 0] + [0] * (n-1)

	p = 2
	loop do
		(p..n).step(p).each { |i| bool_arry[i] += 1 }
		(p+1..n/2+1).each do |k|
			p = k
			break if bool_arry[p] == 0 || p > n/2
		end
		break if p > n/2
	end
	bool_arry
end

ary = sieve(200000)

(2*3*5*7...200000).each do |i|
	if [ary[i], ary[i+1], ary[i+2], ary[i+3]] == [4,4,4,4]
		p i
		break
	end
end

p Time.now - start

# 134043
# 0.180686 seconds