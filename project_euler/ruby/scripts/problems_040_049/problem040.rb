# An irrational decimal fraction is created by concatenating the positive
# integers:

# 0.12345678910*1*112131415161718192021...

# It can be seen that the 12th digit of the fractional part is 1.

# If dn represents the nth digit of the fractional part, find the value of the
# following expression.

# d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

# start = Time.now

def index_for_first_digit_of_10_n(n) # index for the first digit of 10^n
  1 + (1..n).collect{ |k| k * (9 * 10**(k-1))}.reduce(:+)
end

def index_to_order_of_magnitude(n)
  k = 0
  loop do
    return k if index_for_first_digit_of_10_n(k+1) > n
    k += 1
  end
end

def f(n) # number of n-digit terms * n
  (10**n - index_for_first_digit_of_10_n(index_to_order_of_magnitude(10**n)))
end

product = 1
(1..6).each do |i|
  product *= (10**(i-1) + f(i)/i).to_s[f(i) % i].to_i
end

p product
p Time.now - start

# 210
# 0.00011 seconds

# Code is too ugly to bother with cleaning or explaining it.
