class A269427Builder
  def self.sequence(terms = 10)
    (2..terms).inject([1]) do |seq, n|
      seq << (1...n).count { |i| seq[i - 1] % i == n % i }
    end
  end
end

class OEIS
  A269427_SEQUENCE = A269427Builder.sequence

  def self.a269427(n)
    raise "A269427 is not defined for n = #{n} < 1" if n < 1
    A269427_SEQUENCE[n - 1] || A269427Builder.sequence(n).last
  end
end
