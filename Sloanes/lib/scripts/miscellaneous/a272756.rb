require_relative '../helpers/find_next'
require_relative '../helper_sequences/a070939'

class A272756Builder

  def self.sequence(seed, terms)
    return seed if seed.length >= terms
    (seed.length + 1..terms).inject(seed) do |accum, i|
      accum << accum.find_next { |k| k - 1 > OEIS.a070939(i * k - i) } - 1
    end
  end

end

class OEIS
  @@a272756 = [3]

  def self.a272756(n)
    raise "A272756 is not defined for n = #{n} < 1" if n < 1
    @@a272756 = A272756Builder.sequence(@@a272756, n)
    @@a272756[n - 1]
  end
end
