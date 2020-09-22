require_relative '../helpers/alec_sequences'

class A271503Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :*, e = 1, seed) { |a_i, n| n % a_i == 0 }
  end
end

class OEIS
  @@a271503 = A271503Builder.sequence(1, [1])

  def self.a271503(n)
    raise "A271503 is not defined for n = #{n} < 1" if n < 1
    @@a271503 = A271503Builder.sequence(n, @@a271503)
    @@a271503[n - 1]
  end
end
