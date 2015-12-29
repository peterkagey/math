require_relative 'a019555'
class OEIS

  # Least k > n such that n divides k^3.
  def self.a254733(n)
    n + a019555(n)
  end
end
