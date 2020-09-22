require_relative '../helpers/alec_sequences'

class A096216Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :increment, e = 0, seed) do |a_i, n|
      a_i.gcd(n) == 1
    end
  end
end

class OEIS
  @@a096216 = A096216Builder.sequence(1, [1])

  def self.a096216(n)
    raise "A096216 is not defined for n = #{n} < 1" if n < 1
    @@a096216 = A096216Builder.sequence(n, @@a096216)
    @@a096216[n - 1]
  end
end
