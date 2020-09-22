class OEIS
  def self.a270841(n)
    raise "A270841 is not defined for n = #{n} < 1" if n < 1
    n == 1 ? 5 : 2**(n - 2) + n + 1
  end
end
