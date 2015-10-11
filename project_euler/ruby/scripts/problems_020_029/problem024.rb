require_relative '../function/factorial'

start = Time.now

digit_pool = (0..9).to_a
k = ""
n = 10**6
10.times do
  group_size = factorial(digit_pool.length)/digit_pool.length
  digit = digit_pool[(n-1) / group_size]
  digit_pool -= [digit]
  n %= factorial(digit_pool.length)
  k << digit.to_s
end

p k.to_i
p Time.now - start

# 2783915460
# 0.000112 seconds
