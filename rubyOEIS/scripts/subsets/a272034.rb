require_relative '../helpers/find_next'
require_relative 'a116416'

class A272034Builder

  def self.sequence(terms, seed)
    (seed.length...terms).inject(seed) do |accum, _|
      accum << accum.find_next { |i| OEIS.a116416(i) == 1 }
    end
  end
end

class OEIS

  @@a272034 = [1]
  def self.a272034(n)
    @@a272034 = A272034Builder.sequence(n, @@a272034)
    @@a272034[n - 1]
  end

end
