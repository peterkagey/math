require_relative '../helpers/alec_sequences'
require 'prime'

class A270654Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :+, e = 0, seed) do |a_i, n|
      Prime.prime?(a_i + n)
    end
  end
end

class OEIS
  @@a270654 = A270654Builder.sequence(1, [0])

  def self.a270654(n)
    raise "A270654 is not defined for n = #{n} < 1" if n < 1
    @@a270654 = A270654Builder.sequence(n, @@a270654)
    @@a270654[n - 1]
  end
end
