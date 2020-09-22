require_relative 'a272034'
require_relative '../helpers/subset_logic'
class A272081Builder

  def self.sequence(terms, seed)
    until seed.length >= terms
      row_count = seed[1..-1].zip(seed).count { |a, b| a >= b } + 1
      seed += Subset.one_indexed(OEIS.a272034(row_count + 1)).reverse
    end
    seed
  end

end

class OEIS
  @@a272081 = [1]

  def self.a272081(n)
    @@a272081 = A272081Builder.sequence(n, @@a272081)
    @@a272081[n - 1]
  end
end
