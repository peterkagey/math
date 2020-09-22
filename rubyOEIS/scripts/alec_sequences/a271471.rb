require_relative 'a271468'

class A271471Builder
  def self.sequence(terms, seed)
    return seed if seed.length >= terms
    start = (1..Float::INFINITY).find { |i| OEIS.a271468(i) > seed.last }

    (start..Float::INFINITY).inject(seed) do |accum, i|
      case
      when accum.length >= terms
        return accum
      when accum.all? { |k| OEIS.a271468(i) % k != 0 }
        accum << OEIS.a271468(i)
      else
        accum
      end
    end
  end
end

class OEIS
  @@a271471 = A271471Builder.sequence(1, [5])

  def self.a271471(n)
    raise "A271471 is not defined for n = #{n} < 1" if n < 1
    @@a271471 = A271471Builder.sequence(n, @@a271471)
    @@a271471[n - 1]
  end
end
