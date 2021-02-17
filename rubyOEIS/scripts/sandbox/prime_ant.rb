# a(0) = 0:
# 2  3  4  5  6  7 ...
# ^ (prime; step to the right)
#
# a(1) = 1:
# 2  3  4  5  6  7 ...
#    ^ (prime; step to the right)
#
# a(2) = 2:
# 2  3  4  5  6  7 ...
#       ^ (composite; divide by 2, step to the left, add 2)
#
# a(3) = 1:
# 2  5  2  5  6  7 ...
#    ^ (prime; divide by 2, step to the left, add 2)
#
# a(4) = 2:
# 2  5  2  5  6  7 ...
#       ^

require 'prime'
def a(n)
	counter = 0
	list = [2]
	(1..n).each do |_|
		if Prime.prime?(list[counter])
			counter += 1
			list[counter] ||= (counter + 2)
		else
			divisor = (2..Float::INFINITY).find { |d| list[counter] % d == 0 }
			list[counter] /= divisor
			counter -= 1
			list[counter] += divisor
		end
	end
	counter
end

a(10000)
