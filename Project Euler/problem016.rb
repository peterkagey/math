# 215 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

# What is the sum of the digits of the number 2^1000?

start = Time.now
p (2**1000).to_s.split("").map(&:to_i).reduce(:+)
p Time.now-start

# 0.000398 seconds