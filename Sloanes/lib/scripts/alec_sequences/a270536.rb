require_relative '../helpers/alec_sequences'
require 'prime'

class A270536Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :+, seed) { |a_i, n| !Prime.prime?(a_i + n) }
  end
end

class OEIS
  @@a270536 = A270536Builder.sequence(1, [0])

  def self.a270536(n)
    raise "A270536 is not defined for n = #{n} < 1" if n < 1
    @@a270536 = A270536Builder.sequence(n, @@a270536)
    @@a270536[n - 1]
  end
end
