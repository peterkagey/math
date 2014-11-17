# The prime factors of 13195 are 5, 7, 13 and 29.

# What is the largest prime factor of the number 600851475143 ?


start = Time.now
a = 600851475143

(2..a).each do |x| # cycle through composites because it's easier
	loop do
		(a % x == 0) ? a /= x : break
	end
	
	if a == 1
		p x
		break
	end
end
p Time.now-start

# 0.003941 seconds