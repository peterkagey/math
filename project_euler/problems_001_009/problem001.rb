# If we list all the natural numbers below 10 that are multiples of 3 or 5, 
# we get 3, 5, 6 and 9. The sum of these multiples is 23.
# Find the sum of all the multiples of 3 or 5 below 1000.

start = Time.now
p (1...1000).select{ |n| n % 3 == 0 || n % 5 == 0 }.reduce(:+)
p Time.now - start

# 233168
# 0.000164 seconds

def triangle(n); n * (n + 1)/2 end

start = Time.now
p 3 * triangle(999/3) + 5 * triangle(999/5) - 15 * triangle(999/15)
p Time.now - start

# 233168
# 6.0e-06 seconds