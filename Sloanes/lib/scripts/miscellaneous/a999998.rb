require_relative 'a271328'

class A999998Builder
  def self.sequence(terms, seed)
    (seed.max + 1..Float::INFINITY).inject(seed) do |accum, i|
      return accum if accum.length >= terms
      OEIS.a271328(i) != i**2 + 1 ? accum << i : accum
    end
  end
end

class OEIS
  @@a999998 = A999998Builder.sequence(1, [1])

  def self.a999998(n)
    raise "A999998 is not defined for n = #{n} < 1" if n < 1
    @@a999998 = A999998Builder.sequence(n, @@a999998)
    @@a999998[n - 1]
  end
end
