require_relative 'a006255'
require_relative 'a072905'

class Primes
	def a067722(n)
		a072905(n) - n
	end
end

# primes = Primes.new(5000)
# (1..5000).each do |i|
# 	puts "#{i} #{primes.a067722(i)}"
# end