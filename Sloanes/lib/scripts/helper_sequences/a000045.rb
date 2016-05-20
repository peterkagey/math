require_relative 'a032741'

class A000045Builder
  def self.sequence(terms, seed)
    seed << seed[-2..-1].reduce(:+) until seed.length > terms
    seed
  end
end

class OEIS
  @@a000045 = [0, 1]
  def self.a000045(n)
    @@a000045 = A000045Builder.sequence(n, @@a000045)
    @@a000045[n]
  end
end
