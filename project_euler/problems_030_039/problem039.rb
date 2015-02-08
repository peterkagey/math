# If p is the perimeter of a right angle triangle with integer length sides,
# {a,b,c}, there are exactly three solutions for p = 120.

# {20,48,52}, {24,45,51}, {30,40,50}

# For which value of p ≤ 1000, is the number of solutions maximised?

# Solution strategy, find all pythagorean triples.
start = Time.now

def number_of_pythagorean_triples(k)
	triples_ary = []
	(1..Math.sqrt(k/2)).each do |m|
		(1...m).each do |n|
			triple = [m**2 - n**2, 2*m*n, m**2 + n**2].sort
			sum = triple.reduce(:+)
			next unless k % sum == 0
			triples_ary << triple.collect{|x| x * k / sum }
		end
	end
	triples_ary.uniq.count
end


solution_count_ary = []
(0...1000).each do |i|
	solution_count_ary << number_of_pythagorean_triples(i)
end

p solution_count_ary.index(solution_count_ary.max)
p Time.now - start

# 840
# 0.107857 seconds