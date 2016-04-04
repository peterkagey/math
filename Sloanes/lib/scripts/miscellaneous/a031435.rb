class A031435Builder

  def self.a031435(n, m = 1)
    (m..Float::INFINITY).find { |i| (i * Math.log(n, n + 1)).to_i < i - 1 } - 1
  end

  def self.sequence(seed, term)
    return seed if seed[term - 1]
    (seed.length + 1..term).inject(seed) { |a, i| a << a031435(i, a.last) }
  end

end

class OEIS

  @@a031435 = [1]

  def self.a031435(n)
    @@a031435 = A031435Builder.sequence(@@a031435, n)
    @@a031435[n - 1]
  end

end
