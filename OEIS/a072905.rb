require_relative 'a006255'

class Primes
	def a007913(n)
		factors(n).collect { |k,v| k if v.odd? }.compact.reduce(:*) || 1
	end

	def a072905(n)
		squarefree_part_of_n = a007913(n)
		k = (n + 1)/squarefree_part_of_n.to_f
		m = (k**0.5).ceil**2
		(m * squarefree_part_of_n)
	end
end

# primes = Primes.new(5000)
# (1..5000).each do |i|
# 	puts "#{i} #{primes.a072905(i)}"
# end