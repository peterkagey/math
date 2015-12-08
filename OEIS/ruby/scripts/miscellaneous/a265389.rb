class A265389Builder

  def self.sequence(terms = 10000)
    x = (1..10 * terms).to_a
    (0...terms).collect do
      y = x.shift(3).reduce(:+); x.delete_at x.index(y); y
    end
  end

end

class OEIS

  A265389_SEQUENCE = A265389Builder.sequence

  def self.a265389(n)
    raise "A265389 is not defined for n = #{n} < 1" if n < 1
    A265389_SEQUENCE[n - 1] || A265389Builder.sequence(n).last
  end
end
