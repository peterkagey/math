require_relative '../helpers/alec_sequences'

class A269423Builder
  def self.sequence(terms = 10)
    AlecSequences.generate(terms, :+) { |a_i, n, i| a_i % i == n % i }
  end
end

class OEIS
  A269423_SEQUENCE = A269423Builder.sequence

  def self.a269423(n) # A269423
    raise "A269423 is not defined for n = #{n} < 1" if n < 1
    A269423_SEQUENCE[n - 1] || A269423Builder.sequence(n).last
  end
end
