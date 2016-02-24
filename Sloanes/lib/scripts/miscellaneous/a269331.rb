require_relative '../tables/a107435'
require_relative '../tables/a268057'

class A269331Builder
  def self.sequence(terms = 10)
    (1..Float::INFINITY).inject([]) do |accum, i|
      return accum if accum.length == terms
      OEIS.a107435(i) == OEIS.a268057(i) ? accum << i : accum
    end
  end
end

class OEIS
  A269331_SEQUENCE = A269331Builder.sequence

  def self.a269331(n)
    raise "A269331 is not defined for n = #{n} < 1" if n < 1
    A269331_SEQUENCE[n - 1] || A269331Builder.sequence(n).last
  end
end
