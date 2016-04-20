require_relative '/Users/pkagey/personal/math/Sloanes/lib/scripts/helper_sequences/a000120.rb'
class A000788Builder

  def self.sequence(max, seed)
    return seed if max >= seed.length
    (seed.length..max + 1).inject(seed) do |accum, i|
      seed << seed.last + OEIS.a000120(i)
    end
  end

end

class OEIS
  @@a000788 = [0]
  def self.a000788(n)
    @@a000788 = A000788Builder.sequence(n, @@a000788)
    @@a000788[n]
  end
end
