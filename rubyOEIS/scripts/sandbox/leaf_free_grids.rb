require_relative '../helpers/subset_logic'

# 3 x n leaf-free grids
class LeafFreeGrid

  attr_reader :n
  def initialize(n)
    @n = n
  end

  def horizontal_edges
    (1..3).flat_map do |y|
      (1...n).map do |x|
        [[x, y], [x + 1, y]]
      end
    end
  end

  def vertical_edges
    (1..n).flat_map do |x|
      (1..2).map do |y|
        [[x, y], [x, y + 1]]
      end
    end
  end

  def all_edges
    horizontal_edges + vertical_edges
  end
end

def is_valid?(edges)
  h = Hash.new(0)
  edges.flat_map { |points| points }.each { |i| h[i] += 1 }
  h.values.all? { |k| k != 1 }
end
#
p LeafFreeGrid.new(5)
  .all_edges
  .map_subsets { |s| is_valid?(s) }
  .count { |b| b }
