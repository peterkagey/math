require_relative '../tables/a107435'
require_relative '../tables/a268057'

class A269267Builder
  def self.sequence(terms = 10)
    (1..Float::INFINITY).inject([]) do |accum, i|
      return accum if accum.length == terms
      OEIS.a107435(i) != OEIS.a268057(i) ? accum << i : accum
    end
  end
end

class OEIS
  A269267_SEQUENCE = A269267Builder.sequence

  def self.a269267(n)
    raise "A269267 is not defined for n = #{n} < 1" if n < 1
    A269267_SEQUENCE[n - 1] || A269267Builder.sequence(n).last
  end
end
