# A unit fraction contains 1 in the numerator. The decimal representation of
# the unit fractions with denominators 2 to 10 are given:

# 1/2	= 	0.5
# 1/3	= 	0.(3)
# 1/4	= 	0.25
# 1/5	= 	0.2
# 1/6	= 	0.1(6)
# 1/7	= 	0.(142857)
# 1/8	= 	0.125
# 1/9	= 	0.(1)
# 1/10	= 	0.1
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be
# seen that 1/7 has a 6-digit recurring cycle.

# Find the value of d < 1000 for which 1/d contains the longest recurring
# cycle in its decimal fraction part.

start = Time.now

def length_of_recurring_cycle(k)
	list = []
	n = 10
	loop do
		if list.include?(n % k)
			return 0 if list[-1] == 0
			return list.length - list.index(n % k)
		end
		list << n % k
		n = 10 * (n % k)
	end
end

# cycle_list = [0]

# (1...1000).each do |i|
# 	cycle_list << length_of_recurring_cycle(i)
# end

# p cycle_list.index(cycle_list.max)

cycle_hash = {}

1000.downto(1).each do |i|
	cycle_hash[i] = length_of_recurring_cycle(i)
	break if i <= cycle_hash.values.max
end

p cycle_hash.key(cycle_hash.values.max)
p Time.now - start

# 983
# 0.036665 seconds