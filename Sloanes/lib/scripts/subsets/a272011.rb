require_relative '../helper_sequences/a000788'
require_relative '../helpers/subset_logic'

class A272011Builder
  def self.sequence(term, seed)
    len = seed.length
    return seed if len > term
    start = (0..Float::INFINITY).find { |i| OEIS.a000788(i) == len }

    (start..Float::INFINITY).inject(seed) do |accum, i|
      break seed if seed.length > term
      seed += Subset.zero_indexed(i + 1).reverse
    end
  end
end

class OEIS
  @@a272011 = []

  def self.a272011(n)
    @@a272011 = A272011Builder.sequence(n, @@a272011)
    @@a272011[n]
  end
end
