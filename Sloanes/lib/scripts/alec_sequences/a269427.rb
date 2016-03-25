require_relative '../helpers/alec_sequences'

class A269427Builder
  def self.sequence(terms, seed)
    AlecSequences.count(terms, seed) { |a_i, n, i| a_i % i == n % i }
  end
end

class OEIS
  @@a269427 = A269427Builder.sequence(1, [1])

  def self.a269427(n)
    raise "A269427 is not defined for n = #{n} < 1" if n < 1
    @@a269427 = A269427Builder.sequence(n, @@a269427)
    @@a269427[n - 1]
  end
end
