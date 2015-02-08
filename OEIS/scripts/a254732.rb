class OEIS
  def self.a254732(n)
    (n+1..2*n).find { |k| k**2 % n == 0 }
  end
end

# new sequence of sqrt(n * A072905(n))
# min{ k: n*(n + b) = k^2 where b > 0 }
# Least k > n such that n divides k^2.


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
