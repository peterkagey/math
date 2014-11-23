# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

# Find the sum of all numbers which are equal to the sum of the factorial of 
# their digits.

# Note: as 1! = 1 and 2! = 2 are not sums they are not included.

start = Time.now

require_relative '../function/factorial'

# 7*9! = 2,540,160 < 9,999,999 is an upper bound.

def digit_factorial_sum(n)
	n.to_s.split("").collect{ |d| factorial(d.to_i) }.reduce(:+)
end

sum = (10..10**5).select do |i|
	i == digit_factorial_sum(i)
end

p sum.reduce(:+)
p Time.now - start

# 40730
# 0.853797 seconds

# I dislike this solution because 10**5 is arbitrary, albeit sufficient.