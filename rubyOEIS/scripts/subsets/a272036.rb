require_relative '../helpers/find_next'
require_relative 'a116416'
require_relative 'a116417'

class A272036Builder

  def self.sequence(terms, seed)
    (seed.length...terms).inject(seed) do |accum, _|
      accum << accum.find_next { |i| OEIS.a116416(i) == OEIS.a116417(i) }
    end
  end
end

class OEIS

  @@a272036 = [1]
  def self.a272036(n)
    @@a272036 = A272036Builder.sequence(n, @@a272036)
    @@a272036[n - 1]
  end

end
