class A269347Builder
  def self.sequence(terms = 25)
    (2..terms).inject([1]) do |a, i|
      a << (1..a.length).select { |j| i % a[j - 1] == 0 }.reduce(:+)
    end
  end
end

class OEIS
  A269347_SEQUENCE = A269347Builder.sequence

  def self.a269347(n)
    return "A269347 is not defined for n = #{n} < 1" if n < 1
    A269347_SEQUENCE[n - 1] || A269347Builder.sequence(n).last
  end
end
