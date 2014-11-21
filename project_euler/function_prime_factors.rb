def prime_factors(n, primes)
	prime_factors_hash = Hash.new(0)
	primes.each do |k|
		loop do
			break if n % k != 0
			n /= k
			prime_factors_hash[k] += 1 
		end
		break if n == 1
	end
	prime_factors_hash
end