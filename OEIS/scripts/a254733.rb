require_relative 'a019555'
class OEIS

  def self.a254733(n)
    # Least k > n such that n divides k^3.
    # (n+1..2*n).find { |k| k**3 % n == 0 }
    n + a019555(n)
  end
end
