require_relative 'a065879'
require_relative 'a065880'

class A272761Builder
  def self.sequence(terms, seed)
    (seed.length..terms).inject(seed) do |accum, i|
      accum << accum.find_next { |i| OEIS.a065879(i) != OEIS.a065880(i) }
    end
  end
end

class OEIS
  @@a272761 = [23]
  def self.a272761(n)
    A272761Builder.sequence(n, @@a272761)
    @@a272761[n - 1]
  end
end
