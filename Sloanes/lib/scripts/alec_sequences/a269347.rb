require_relative '../helpers/alec_sequences'

class A269347Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :+, seed) { |a_i, n| n % a_i == 0 }
  end
end

class OEIS
  @@a269347 = A269347Builder.sequence(1, [1])

  def self.a269347(n)
    raise "A269347 is not defined for n = #{n} < 1" if n < 1
    @@a269347 = A269347Builder.sequence(n, @@a269347)
    @@a269347[n - 1]
  end
end
