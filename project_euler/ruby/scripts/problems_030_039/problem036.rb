# The decimal number, 585 = 1001001001_2 (binary), is palindromic in both
# bases.

# Find the sum of all numbers, less than one million, which are palindromic in
# base 10 and base 2.

# (Please note that the palindromic number, in either base, may not include
# leading zeros.)

start = Time.now
pal_ary = []
(1..999).each do |i|
	pal_ary << i.to_s[0...-1] + i.to_s.reverse
	pal_ary << i.to_s + i.to_s.reverse
end

p pal_ary.map(&:to_i).select{|n| n.to_s(2) == n.to_s(2).reverse}.reduce(:+)
p Time.now - start

# 872187
# 0.003319 seconds

# Maybe as clever as the last one!