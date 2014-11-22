# The prime factors of 13195 are 5, 7, 13 and 29.

# What is the largest prime factor of the number 600851475143 ?

start = Time.now
a = 600851475143

c = 1
loop do # cycle through composites because it's easier
	c += 1
	loop do; (a % c == 0 ? a /= c : break) end	
	break if a == 1
end
p c
p Time.now-start

# 6857
# 0.002216 seconds