# Surprisingly there are only three numbers that can be written as the sum of
# fourth powers of their digits:

# 1634 = 1^4 + 6^4 + 3^4 + 4^4
# 8208 = 8^4 + 2^4 + 0^4 + 8^4
# 9474 = 9^4 + 464 + 7^4 + 4^4
# As 1 = 1^4 is not a sum it is not included.

# The sum of these numbers is 1634 + 8208 + 9474 = 19316.

# Find the sum of all the numbers that can be written as the sum of fifth
# powers of their digits.

start = Time.now

def digit_power_sum(n, k)
	n.to_s.split("").map{ |x| (x.to_i)**k }.reduce(:+)
end

# 6 * 9^5 = 354,294 < 999,999
sum = (2**5..354294).select do |i|
	i == digit_power_sum(i, 5)
end

p sum.reduce(:+)
p Time.now - start

# 443839
# 2.484822 seconds

# Brute force, but it works.