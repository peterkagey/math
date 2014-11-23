# The number, 1406357289, is a 0 to 9 pandigital number because it is made up 
# of each of the digits 0 to 9 in some order, but it also has a rather 
# interesting sub-string divisibility property.

# Let d_1 be the 1st digit, d_2 be the 2nd digit, and so on. In this way, we 
# note the following=>

# d_2 d_3 d_4 = 406 is divisible by 2
# d_3 d_4 d_5 = 063 is divisible by 3
# d_4 d_5 d_6 = 635 is divisible by 5
# d_5 d_6 d_7 = 357 is divisible by 7
# d_6 d_7 d_8 = 572 is divisible by 11
# d_7 d_8 d_9 = 728 is divisible by 13
# d_8 d_9 d_10 = 289 is divisible by 17
# Find the sum of all 0 to 9 pandigital numbers with this property.

start = Time.now

def other_numbers(n_string); (0..9).to_a.map(&:to_s) - n_string.split("") end
def first_three_divisible_by?(n, k); n[0...3].to_i % k == 0 end

seeds = (0..9).to_a.map(&:to_s)
p = [1,17,13,11,7,5,3,2,1]

(0...9).each do |i|
	seeds.collect!{ |x| other_numbers(x).map{|a| a + x}}.flatten!
	seeds.select!{ |x| first_three_divisible_by?(x, p[i]) }
end

p seeds.select{|x| x[0] != 0}.map(&:to_i).reduce(:+)
p Time.now - start
# 16695334890
# 0.012937 seconds