require_relative 'a272035'
require_relative '../helpers/subset_logic'
class A272082Builder

  def self.sequence(terms, seed)
    until seed.length >= terms
      row_count = seed[1..-1].zip(seed).count { |a, b| a >= b } + 1
      seed += Subset.one_indexed(OEIS.a272035(row_count + 2)).reverse
    end
    seed
  end

end

class OEIS
  @@a272082 = [1]

  def self.a272082(n)
    @@a272082 = A272082Builder.sequence(n, @@a272082)
    @@a272082[n - 1]
  end
end

# Irregular triangle read by rows: Lexicographically ordered, strictly
# decreasing integer sequences with the property that the sum of inverses is
# an integer.

# [1]
# [6, 3, 2]
# [6, 3, 2, 1]
# [12, 6, 4, 2]
# [12, 6, 4, 2, 1]
# [15, 10, 3, 2]
# [15, 10, 3, 2, 1]
# [15, 12, 10, 4, 2]
# [15, 12, 10, 4, 2, 1]
# [15, 12, 10, 6, 4, 3]
# [15, 12, 10, 6, 4, 3, 1]
# [18, 9, 3, 2]
# [18, 9, 3, 2, 1]
# [18, 12, 9, 4, 2]
# [18, 12, 9, 4, 2, 1]
# [18, 12, 9, 6, 4, 3]
# [18, 12, 9, 6, 4, 3, 1]
# [18, 15, 10, 9, 6, 2]
# [18, 15, 10, 9, 6, 2, 1]
# [18, 15, 12, 10, 9, 4, 3]
# [18, 15, 12, 10, 9, 4, 3, 1]
# [20, 5, 4, 2]
# [20, 5, 4, 2, 1]
# [20, 6, 5, 4, 3]
# [20, 6, 5, 4, 3, 1]
# [20, 12, 6, 5, 2]
# [20, 12, 6, 5, 2, 1]
# [20, 15, 10, 5, 4, 3]
# [20, 15, 10, 5, 4, 3, 1]
# [20, 15, 12, 10, 5, 2]
# [20, 15, 12, 10, 5, 2, 1]
# [20, 15, 12, 10, 6, 5, 3]
# [20, 15, 12, 10, 6, 5, 3, 1]
# [20, 18, 9, 5, 4, 3]
# [20, 18, 9, 5, 4, 3, 1]
# [20, 18, 12, 9, 5, 2]
