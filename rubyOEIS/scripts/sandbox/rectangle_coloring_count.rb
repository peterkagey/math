# 16576# A054247
# Table read by antidiagonals: T(n, k), n > 0, k > 0, gives the number of binary pattern classes in the (n,k)-rectangular grid; two patterns are in same class if one of them can be obtained by reflexion or rotation of the other one.
# But for n x m rectangles
class RectangleColoringCount

  # n x n Square
  def initialize(n, m = nil)
    @n = n      # height
    @m = m || n # width
  end

  def count!
    unique_configurations { |i| i }.size
  end

  # private

  def all_representations(r)
    reflections = [
      r,
      r.map(&:reverse),
      r.reverse,
      r.reverse.map(&:reverse),
    ]

    @n != @m ? reflections : reflections + reflections.map(&:transpose)
  end

  def unique_configurations
    all_configurations { |i| i }.
      group_by { |c| all_representations(c).sort.last }
  end

  def all_configurations
    (0...2**(@n*@m)).map { |i| yield number_to_configuration(i) }
  end

  def number_to_configuration(k)
    Array.new(@n) { |i| Array.new(@m) { |j| k[@m * i + j]} }
  end

end

# require '/Users/pkagey/personal/math/OEIS/Sloanes/lib/scripts/helpers/table.rb'
# (0..20).each { |i| a, b =  OEISTable.n_k(i).map(&:next); p [a, b, RectangleColoringCount.new(a, b).count!] }


# Similar to A225910 (but 90° rotations are allowed for squares)!
# T(n, k) = A225910(n, k) if n != k
# T(n, n) = A054247(n)
#
#       m=1   2    3     4     5    6
#       +-----------------------------
#     1 | 2,  3,   6,    10,   20,  36  <- A005418
#     2 | 3,  6,   24,   76,   288,     <- A132390
# n = 3 | 6,  24,  102,  1120,
#     4 | 10, 76,  1120,
#     5 | 20, 288,
#     6 | 36,

##############################################
# Above table, but with n >= m:
# [1, 1, 2]
# [2, 1, 3]
# [3, 1, 6]
# [2, 2, 6]
# [4, 1, 10]
# [3, 2, 24]
# [5, 1, 20]
# [4, 2, 76]
# [3, 3, 102]
# [6, 1, 36]
# [5, 2, 288]
# [4, 3, 1120]
