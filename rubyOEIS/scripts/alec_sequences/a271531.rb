require_relative '../helpers/alec_sequences'

class A271531Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :lcm, e = 1, seed) do |a_i, n, i|
      a_i % i == n % i
    end
  end
end

class OEIS
  @@a271531 = A271531Builder.sequence(1, [1])

  def self.a271531(n)
    raise "A271531 is not defined for n = #{n} < 1" if n < 1
    @@a271531 = A271531Builder.sequence(n, @@a271531)
    @@a271531[n - 1]
  end
end
