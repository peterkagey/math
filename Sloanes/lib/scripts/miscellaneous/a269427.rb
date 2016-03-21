class A269427Builder
  def self.sequence(terms = 1, seed = [1])
    (seed.length + 1..terms).inject(seed) do |seq, n|
      seq << (1...n).count { |i| seq[i - 1] % i == n % i }
    end
  end
end

class OEIS
  @@a269427 = A269427Builder.sequence

  def self.a269427(n)
    raise "A269427 is not defined for n = #{n} < 1" if n < 1
    @@a269427 = A269427Builder.sequence(n, @@a269427)
    @@a269427[n - 1]
  end
end
