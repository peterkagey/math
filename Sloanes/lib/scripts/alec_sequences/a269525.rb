require_relative '../helpers/alec_sequences'
require_relative '../helper_sequences/a032741'

class A269525Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :+, 0, seed) do |i, n|
      OEIS.a032741(i) <= OEIS.a032741(n)
    end
  end
end

class OEIS
  @@a269525 = A269525Builder.sequence(1, [1])

  def self.a269525(n)
    raise "A269525 is not defined for n = #{n} < 1" if n < 1
    @@a269525 = A269525Builder.sequence(n, @@a269525)
    @@a269525[n - 1]
  end
end
