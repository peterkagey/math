class OEIS

  # a(n) is the least k > n such that n divides k^2.
  def self.a254732(n)
    (n+1..2*n).find { |k| k**2 % n == 0 }
  end

end
