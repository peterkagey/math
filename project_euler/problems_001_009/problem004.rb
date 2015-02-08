# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

start = Time.now

c = 0
999.downto(100).each do |a|
	k = [c/a, a].max
	(k...999).each do |b|
		str = (a*b).to_s
		c = a * b if str == str.reverse
	end
end

p c
p Time.now - start

# 906609
# 0.002313 seconds