class A137734Builder
  def self.sequence(seed, term)
    return seed if term < seed.length
    max = seed.max
    (seed.length..term).inject(seed) do |accum, i|
      a_i = (i.to_f/max).ceil
      max = [max, a_i].max
      accum << a_i
    end
  end
end

class OEIS

  @@a137734 = [1]
  def self.a137734(n)
    @@a137734 = A137734Builder.sequence(@@a137734, n)
    @@a137734[n]
  end

end
