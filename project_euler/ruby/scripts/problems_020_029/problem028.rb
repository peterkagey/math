# Starting with the number 1 and moving to the right in a clockwise direction
# a 5 by 5 spiral is formed as follows:

# 21 22 23 24 25
# 20  7  8  9 10
# 19  6  1  2 11
# 18  5  4  3 12
# 17 16 15 14 13

# It can be verified that the sum of the numbers on the diagonals is 101.

# What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral
# formed in the same way?

##########################################################################
# 1^2 + 4 * (3^2 + 5^2 + ... + 101^2) - (1+2+3)*(2 + 4 + 6 + ... + 100)? #
##########################################################################
start = Time.now

x = (1..500).collect{ |i| (2*i + 1)**2 }
y =	(1..x.length).collect{ |i| 2 * i }

p 4 * x.reduce(:+) - 6 * y.reduce(:+) + 1
p Time.now - start
# 669171001
# 0.000229 seconds