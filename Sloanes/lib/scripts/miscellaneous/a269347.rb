require_relative '../helpers/alec_sequences'

class A269347Builder
  def self.sequence(terms = 10)
    AlecSequences.generate(terms, :+) { |a_i, n| n % a_i == 0 }
  end
end

class OEIS
  A269347_SEQUENCE = A269347Builder.sequence

  def self.a269347(n)
    raise "A269347 is not defined for n = #{n} < 1" if n < 1
    A269347_SEQUENCE[n - 1] || A269347Builder.sequence(n).last
  end
end
