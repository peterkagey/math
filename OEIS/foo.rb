require_relative 'a006255'
require_relative 'a072905'

# new sequence of sqrt(n * A072905(n))
# min{ k: n*(n + b) = k^2 where b > 0 }

class Primes
	def foo(n)
		product = 1
		factors(n * a072905(n)).each do |k,v|
			raise "this doesn't appear to be square!" if v.odd?
			product *= k**(v/2) unless v == 0
		end
		product
	end
end

# primes = Primes.new(5000)
# (1..5000).each do |i|
# 	puts "#{i} #{primes.foo(i)}"
# end