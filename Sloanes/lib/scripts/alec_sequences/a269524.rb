require_relative '../helpers/alec_sequences'
require_relative '../helper_sequences/a032741'

class A269524Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :increment, 0, seed) do |a_i, n|
      OEIS.a032741(a_i) <= OEIS.a032741(n)
    end
  end
end

class OEIS
  @@a269524 = A269524Builder.sequence(1, [1])

  def self.a269524(n)
    raise "A269524 is not defined for n = #{n} < 1" if n < 1
    @@a269524 = A269524Builder.sequence(n, @@a269524)
    @@a269524[n - 1]
  end
end
