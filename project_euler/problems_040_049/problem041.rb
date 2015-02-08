# We shall say that an n-digit number is pandigital if it makes use of all the
# digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is
# also prime.

# What is the largest n-digit pandigital prime that exists?

start = Time.now

def is_prime?(p) # Trial dividing is faster than sieving here
	(2..Math.sqrt(p)).each { |i| return false if p % i == 0 }
	return true
end

def n_pandigital?(a,n)
	!!("#{a}".split("").uniq.join =~ /^[1-#{n}]{#{n}}$/)
end

# It can't be 9 digits long because 1 + 2 + ... + 9 = 45 is divisible by 9
# It can't be 8 digits long because 1 + 2 + ... + 8 = 36 is divisible by 9
# It can be a seven digit number, but no larger than 7,654,321.

7654321.downto(7650000).each do |i| # Slow, but quick enough
	next unless n_pandigital?(i, 7)
	if is_prime?(i)
		p i
		break
	end
end

p Time.now - start
# 7652413
# 0.032132 seconds