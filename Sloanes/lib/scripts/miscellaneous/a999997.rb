require_relative 'a999998'

class A999997Builder
  def self.sequence(terms, seed)
    return seed if seed.length >= terms
    start = (1..Float::INFINITY).find { |i| OEIS.a999998(i) > seed.last }

    (start..Float::INFINITY).inject(seed) do |accum, i|
      return accum if accum.length >= terms
      seed.all? { |k| OEIS.a999998(i) % k != 0 } ? accum << OEIS.a999998(i) : accum
    end
  end
end

class OEIS
  @@a999997 = A999997Builder.sequence(1, [5])

  def self.a999997(n)
    raise "A999997 is not defined for n = #{n} < 1" if n < 1
    @@a999997 = A999997Builder.sequence(n, @@a999997)
    @@a999997[n - 1]
  end
end
