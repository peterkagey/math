# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see 
# that the 6th prime is 13.
# What is the 10 001st prime number?

start = Time.now
def sieve_of_eratosthenes(n)
	return [] if n < 2
	p = 2
	bool_arry = [false] + [false] + [true] * (n-1)
	loop do
		(2*p..n).step(p).each { |i| bool_arry[i] = false }
		index = bool_arry[p+1..n].index{ |x| x }
		break if index.nil?
		p = index + p + 1
	end
	bool_arry.each_index.select{ |i| bool_arry[i] }
end

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

# 0.896943 seconds