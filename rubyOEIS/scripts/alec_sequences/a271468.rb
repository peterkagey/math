require_relative 'a271328'

class A271468Builder
  def self.sequence(terms, seed)
    (seed.max + 1..Float::INFINITY).inject(seed) do |accum, i|
      return accum if accum.length >= terms
      OEIS.a271328(i) != i**2 + 1 ? accum << i : accum
    end
  end
end

class OEIS
  @@a271468 = A271468Builder.sequence(1, [1])

  def self.a271468(n)
    raise "A271468 is not defined for n = #{n} < 1" if n < 1
    @@a271468 = A271468Builder.sequence(n, @@a271468)
    @@a271468[n - 1]
  end
end
