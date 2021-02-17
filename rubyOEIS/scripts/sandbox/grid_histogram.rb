require 'set'
# The following puzzle gives a blank board, with each column/row labeled with the
# number of marks to be placed in that column/row.
# The following board could be filled several ways:
#     1   2   1
#   ┌───┬───┬───┐
# 2 │   │   │   │
#   ├───┼───┼───┤
# 1 │   │   │   │
#   ├───┼───┼───┤
# 1 │   │   │   │
#   └───┴───┴───┘

#     1   2   1               1   2   1              1   2   1
#   ┌───┬───┬───┐           ┌───┬───┬───┐          ┌───┬───┬───┐
# 2 │ x │   │ x │         2 │ x │ x │   │        2 │   │ x │ x │
#   ├───┼───┼───┤           ├───┼───┼───┤          ├───┼───┼───┤
# 1 │   │ x │   │   -OR-  1 │   │ x │   │ -OR-   1 │ x │   │   │ (etc)
#   ├───┼───┼───┤           ├───┼───┼───┤          ├───┼───┼───┤
# 1 │   │ x │   │         1 │   │   │ x │        1 │   │ x │   │
#   └───┴───┴───┘           └───┴───┴───┘          └───┴───┴───┘

# How many such histograms uniquely describe a grid?  A048163
# How many such histograms total? 2, 15, 328, 16145
# How many histograms up to D8 action?
# How many such histograms have no solutions?
# Which histograms share the greatest number of states? All values are floor(n/2).
#   How many? 1, 2, 6, 90, 2040

# This could be done with triangular arrays too (with a bit more ambiguity):
# 1 ->    *
# 0 ->   o o
# 2 ->  * o *
# 2 -> o o * *
#     / / / /
#    2 0 2 1
class GridHistogram

  # (3, 0b111_001_011) corresponds to
  # ┌───┬───┬───┐
  # │ 1 │ 1 │ 0 │
  # ├───┼───┼───┤
  # │ 1 │ 0 │ 0 │
  # ├───┼───┼───┤
  # │ 1 │ 1 │ 1 │
  # └───┴───┴───┘
  def initialize(n, seed)
    @n = n
    @seed = seed
  end

  def column_histogram
    Array.new(@n) do |i|
      (0...@n).reduce(0) { |accum, j| accum + @seed[j * @n + i] }
    end
  end

  def row_histogram
    Array.new(@n) do |i|
      (0...@n).reduce(0) { |accum, j| accum + @seed[i * @n + j] }
    end
  end
end

n = ARGV[0].to_i
x = (0...2**(n*n)).group_by do |seed|
  grid = GridHistogram.new(n, seed)
  [grid.column_histogram, grid.row_histogram]
end

p x.max_by { |_, v| v.length }
p x.max_by { |_, v| v.length }[1].length
