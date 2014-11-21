def pandigital_product?(a, b)
	!!("#{a}#{b}#{a * b}".split("").uniq.join =~ /^[1-9]{9}$/)
end

def range_of_correct_number_of_digits(a, b)
	power = 9 - a.to_s.length - b.to_s.length
	max_product = 10**power - 1
	min_product = 10**(power-1)
	[max_product, min_product]
end

p range_of_correct_number_of_digits(1,1)

a_b_list = []
(1..999).each do |x|
	(x...999).each do |y|
		# next unless x.to_s.length + y.to_s.length + (x*y).to_s.length == 9
		a_b_list << x*y if pandigital_product?(x,y) && x.to_s.length + y.to_s.length + (x*y).to_s.length == 9
	end
end

p a_b_list.reduce(:+)
