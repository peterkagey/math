class OEIS
  def a254732(n)
    (n+1..2*n).find { |k| k**2 % n == 0 }
  end
end

# require_relative 'a006255'
# require_relative 'a072905'

# new sequence of sqrt(n * A072905(n))
# min{ k: n*(n + b) = k^2 where b > 0 }
# Least k > n such that n divides k^2.

# class Primes
# 	def foo(n)
# 		product = 1
# 		factors(n * a072905(n)).each do |prime, power|
# 			raise "this doesn't appear to be square!" if power.odd?
# 			product *= prime**(power/2)
# 		end
# 		product
# 	end
# end
# (1..5000).each do |i|
#   puts "#{i} #{a(i)}"
# end

# Comments: If n is squarefree then a(n) = 2 * n.
# a072905(n) = squarefree_part(n)*(sqrt(square_part(n))+1)^2:
# a072905(n) = A007913(n)*(A000188(n)+1)**2

# a(n) = sqrt(A072905(n) * n)
# a(n) = sqrt(A007913(n)*(A000188(n)+1)**2 * n)
# a(n) = sqrt(A007913(n) * n) * (A000188(n)+1)
# a(n) = sqrt(A053143(n)) * (A000188(n)+1)
# a(n) = A019554(n) * (A000188(n)+1)

# The least k such that there exists an integer m > n with the property that n * m = k^2.
# e.g. a(2) = 4   because 2*8   = 4^2
# e.g. a(12) = 18 because 12*27 = 18^2
