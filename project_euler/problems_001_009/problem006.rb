# The sum of the squares of the first ten natural numbers is,

# 1^2 + 2^2 + ... + 10^2 = 385
# The square of the sum of the first ten natural numbers is,

# (1 + 2 + ... + 10)^2 = 552 = 3025
# Hence the difference between the sum of the squares of the first ten
# natural numbers and the square of the sum is 3025 − 385 = 2640.

# Find the difference between the sum of the squares of the first one hundred
# natural numbers and the square of the sum.

start = Time.now

n = 100
sum_to_n_squared = (n * (n + 1) / 2)**2 	   # = (1 + 2 + ... + n)^2
sum_of_squares   = n * (n + 1) * (2 * n + 1)/6 # = 1^2 + 2^2 + ... + n^2

p sum_to_n_squared - sum_of_squares
p Time.now - start

# 25164150
# 2.5e-05 seconds