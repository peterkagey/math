class A137735Builder
  def self.sequence(seed, term)
    return seed if term < seed.length
    max = seed.max
    (seed.length..term).inject(seed) do |accum, i|
      a_i = i/max
      max = [max, a_i].max
      accum << a_i
    end
  end
end

class OEIS

  @@a137735 = [1]
  def self.a137735(n)
    @@a137735 = A137735Builder.sequence(@@a137735, n)
    @@a137735[n]
  end

end
