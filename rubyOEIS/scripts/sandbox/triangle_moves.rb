class TriangleMovesCounting

  def initialize(n)
    @n = n
  end

  # This probably isn't the right way to go, but it will work for now.
  def each_position(&block)
    (0...@n).flat_map do |x|
      (0..x).map { |y| yield(x, y) }
    end
  end

  def count_moves(positions)
    each_position { |x, y| count_position(x, y, positions) }.reduce(:+)
  end

  def count_position(x, y, positions)
    return 0 unless positions.include?([x, y])
    directions
      .map { |d| count_in_direction(0, x, y, positions, d) }
      .reduce(:+)
  end

  def count_in_direction(current_count, x, y, positions, direction)
    return current_count - 1 if y > x || x >= @n || [x, y].min < 0
    x_1, y_1 = direction[x, y]
    return current_count if positions.include?([x_1, y_1])
    count_in_direction(current_count + 1, x_1, y_1, positions, direction)
  end

  def directions
    [
      ->(x, y){[x, y + 1]}, # -
      ->(x, y){[x, y - 1]}, # -

      ->(x, y){[x - 1, y]}, # /
      ->(x, y){[x + 1, y]}, # /

      ->(x, y){[x + 1, y + 1]}, # \
      ->(x, y){[x - 1, y - 1]}, # \
    ]
  end

end
