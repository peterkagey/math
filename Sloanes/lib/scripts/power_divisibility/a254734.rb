class OEIS
  # a(n) is the least k > n such that n divides k^4.
  def self.a254734(n)
    (n+1..2*n).find { |k| k**4 % n == 0 }
  end
end
