require_relative '../helpers/alec_sequences'

class A271504Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :lcm, e = 1, seed) { |a_i, n| n % a_i == 0 }
  end
end

class OEIS
  @@a271504 = A271504Builder.sequence(1, [1])

  def self.a271504(n)
    raise "A271504 is not defined for n = #{n} < 1" if n < 1
    @@a271504 = A271504Builder.sequence(n, @@a271504)
    @@a271504[n - 1]
  end
end
