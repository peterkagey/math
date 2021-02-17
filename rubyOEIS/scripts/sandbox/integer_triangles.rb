require 'set'

class Triangle
  attr_reader :x_1, :x_2, :x_3, :y_1, :y_2, :y_3
  def initialize(p_1, p_2, p_3)
    @x_1, @y_1 = p_1
    @x_2, @y_2 = p_2
    @x_3, @y_3 = p_3
  end

  def distinct_points?
    [x_1, y_1] != [x_2, y_2] &&
    [x_2, y_2] != [x_3, y_3] &&
    [x_1, y_1] != [x_3, y_3]
  end

  def non_colinear?
    (y_1 - y_2)*(x_3 - x_2) != (x_1 - x_2)*(y_3 - y_2)
  end

  def is_valid?
    distinct_points? && non_colinear?
  end

  def lengths
    [
      (x_1 - x_2)**2 + (y_1 - y_2)**2,
      (x_1 - x_3)**2 + (y_1 - y_3)**2,
      (x_2 - x_3)**2 + (y_2 - y_3)**2,
    ].sort
  end

  def perimeter
    lengths.map { |i| Math.sqrt(i) }.reduce(:+)
  end

  def to_s
    "Triangle: (#{x_1}, #{y_1}), (#{x_2}, #{y_2}), (#{x_3}, #{y_3})".ljust(40) +
    "#{lengths} ".ljust(22) +
    "#{perimeter}"
  end

  def inspect; to_s end
end

# The idea is that I want to classify all of the triangles with integer coefficients by perimeter.
# To do this, count all triangles that touch three sides of an n X m
class IntegerTriangles
  def initialize(n, m)
    @n = n
    @m = m
  end

  def all_triangles
    border_triangles + interior_triangles
  end

  def all_side_lengths
    all_triangles.map(&:lengths)
  end

  private
  # This counts roughly twice as many points as necessary, by taking points
  # below and on the diagonal.
  def interior_triangles
    (0..@m).flat_map do |i|
      (0..@n)
        .map { |j| Triangle.new([0, 0], [@m, @n], [i, j]) }
        .select(&:is_valid?)
    end
  end

  # Take one point from the top border, and another from the right border.
  def border_triangles
    (0...@m).flat_map do |i|
      (0...@n)
        .map { |j| Triangle.new([0, 0], [i, @n], [@m, j]) }
        .select(&:is_valid?)
    end
  end
end

upper_bound = 30

all_integer_triangles = (1..upper_bound).flat_map do |n|
  (1..n).flat_map { |k| IntegerTriangles.new(n, k).all_triangles }
end

all_integer_triangles
  .uniq { |triangle| triangle.lengths }
  .group_by { |triangle| triangle.perimeter.to_i }
  .sort_by(&:first)
  .take(2 * upper_bound - 4)
  .flat_map { |_, triangles| triangles.sort_by(&:perimeter) }
  .each_with_index
  .each { |t, i| puts "#{i + 1}".ljust(6) +  " #{t}"}
