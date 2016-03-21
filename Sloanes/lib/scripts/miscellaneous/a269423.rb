require_relative '../helpers/alec_sequences'

class A269423Builder
  def self.sequence(terms, known)
    AlecSequences.generate(terms, :+, known) { |a_i, n, i| a_i % i == n % i }
  end
end

class OEIS
  @@a269423 = A269423Builder.sequence(1, [1])

  def self.a269423(n)
    raise "A269423 is not defined for n = #{n} < 1" if n < 1
    @@a269423 = A269423Builder.sequence(n, @@a269423)
    @@a269423[n - 1]
  end
end
