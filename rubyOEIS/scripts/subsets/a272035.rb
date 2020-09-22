require_relative '../helpers/find_next'
require_relative 'a116417'

class A272035Builder

  def self.sequence(terms, seed)
    (seed.length...terms).inject(seed) do |accum, _|
      accum << accum.find_next { |i| OEIS.a116417(i) == 1 }
    end
  end
end

class OEIS

  @@a272035 = [0]
  def self.a272035(n)
    @@a272035 = A272035Builder.sequence(n, @@a272035)
    @@a272035[n - 1]
  end

end
