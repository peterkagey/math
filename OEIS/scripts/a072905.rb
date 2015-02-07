require_relative 'prime_factor_hash'
require_relative 'a000188'
require_relative 'a007913'

class OEIS
	def self.a072905(n)
    # A072905: Least k > n such that k*n is a square.
    a007913(n)*(a000188(n)+1)**2
	end
end

# Comments: If n is squarefree then a(n) = 2 * n.
# a072905(n) = squarefree_part(n)*(sqrt(square_part(n))+1)^2:
# a(n) = A007913(n)*(A000188(n)+1)**2

# primes = Primes.new(5000)
# (1..5000).each do |i|
# 	puts "#{i} #{primes.a072905(i)}"
# end