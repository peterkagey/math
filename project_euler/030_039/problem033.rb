# The fraction 49/98 is a curious fraction, as an inexperienced mathematician 
# in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which 
# is correct, is obtained by cancelling the 9s.

# We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

# There are exactly four non-trivial examples of this type of fraction, less 
# than one in value, and containing two digits in the numerator and 
# denominator.

# If the product of these four fractions is given in its lowest common terms, 
# find the value of the denominator.

start = Time.now

def simp(a,b)
	a = a.to_i; b = b.to_i
	gcd = a.gcd(b)
	[a / gcd, b / gcd]
end

n_product = 1
d_product = 1
(12...97).each do |n|
	((n+1)..98).each do |d|
		next if d % 10 == 0 || n % 10 == 0  # contains zero
		next if d % 11 == 0 || n % 11 == 0  # repdigits don't play ball
		numerator = n.to_s.split("") 		# converts to digit array
		denominator = d.to_s.split("")
		intersection = numerator & denominator # digit intersection
 		next unless intersection.length == 1   # no/both digits in common

		new_n = (numerator - intersection)[0]
		new_d = (denominator - intersection)[0]

		if simp(new_n, new_d) == simp(n, d)
			n_product *= n; d_product *= d
		end
	end
end

p simp(n_product, d_product)[1]
p Time.now - start

# 100
# 0.021994 seconds