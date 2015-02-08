# We shall say that an n-digit number is pandigital if it makes use of all the
# digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1
# through 5 pandigital.

# The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing
# multiplicand, multiplier, and product is 1 through 9 pandigital.

# Find the sum of all products whose multiplicand/multiplier/product identity
# can be written as a 1 through 9 pandigital.

# HINT: Some products can be obtained in more than one way so be sure to only
# include it once in your sum.

start = Time.now

def pandigital_product?(a, b)
	!!("#{a}#{b}#{a * b}".split("").uniq.join =~ /^[1-9]{9}$/)
end

def l(i); i.to_s.length end

a_b_list = []
(1..98).each do |x|
	(x...4999).each do |y|
		break if l(x) + l(y) + l(x*y) > 9
		next unless pandigital_product?(x,y) && l(x) + l(y) + l(x*y) == 9
		a_b_list << x * y
	end
end

p a_b_list.uniq.reduce(:+)
p Time.now - start

# 45228
# 0.41698 seconds