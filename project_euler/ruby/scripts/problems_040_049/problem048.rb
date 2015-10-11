# The series, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

# Find the last ten digits of the series, 1^1 + 2^2 + 3^3 + ... + 1000^1000.

start = Time.now

def product_mod_k(n,k)
  product = 1
  n.times {product = n * product % 10**10}
  product
end

sum = 0
(1..1000).each do |i|
  sum += product_mod_k(i,10**10)
end

p sum % 10**10
p Time.now - start

# 9110846700
# 0.074681 seconds
