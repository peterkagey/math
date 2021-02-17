class ChessCounting
  def initialize(n)
    @n = n
  end

  def each_position(&block)
    (0...@n).flat_map do |x|
      (0...@n).map { |y| yield(x, y) }
    end
  end

  def count_moves(positions)
    each_position { |x, y| count_position(x, y, positions) }.reduce(:+)
  end

  def directions
    raise NotImplementedError # This should be implemented by the child class
  end

end

class SimpleChessCounting < ChessCounting
  def count_position(x, y, positions)
    return 0 unless positions.include?([x, y])
    directions.count do |f|
      x_1, y_1 = f[x, y]
      in_range = [x_1, y_1].min >= 0 && [x_1, y_1].max < @n
      in_range && !positions.include?([x_1, y_1])
    end
  end
end

class IteratedChessCounting < ChessCounting

  def count_position(x, y, positions)
    return 0 unless positions.include?([x, y])
    directions
      .map { |d| count_in_direction(0, x, y, positions, d) }
      .reduce(:+)
  end

  def count_in_direction(current_count, x, y, positions, direction)
    return current_count - 1 if [x, y].min < 0 || [x, y].max >= @n
    x_1, y_1 = direction[x, y]
    return current_count if positions.include?([x_1, y_1])

    count_in_direction(current_count + 1, x_1, y_1, positions, direction)
  end

end

class RookCounting < IteratedChessCounting
  def directions
    [
      ->(x, y){[x, y + 1]}, # n
      ->(x, y){[x - 1, y]}, # w
      ->(x, y){[x, y - 1]}, # s
      ->(x, y){[x + 1, y]}, # e
    ]
  end
end

class QueenCounting < IteratedChessCounting
  def directions
    [
      ->(x, y){[x, y + 1]}, # n
      ->(x, y){[x - 1, y]}, # w
      ->(x, y){[x, y - 1]}, # s
      ->(x, y){[x + 1, y]}, # e

      ->(x, y){[x + 1, y + 1]}, # ne
      ->(x, y){[x - 1, y + 1]}, # nw
      ->(x, y){[x + 1, y - 1]}, # se
      ->(x, y){[x - 1, y - 1]}, # sw
    ]
  end
end

class BishopCounting < IteratedChessCounting
  def directions
    [
      ->(x, y){[x + 1, y + 1]}, # ne
      ->(x, y){[x - 1, y + 1]}, # nw
      ->(x, y){[x + 1, y - 1]}, # se
      ->(x, y){[x - 1, y - 1]}, # sw
    ]
  end
end

class KingCounting < SimpleChessCounting
  def directions
    [
      ->(x, y){[x, y + 1]}, # n
      ->(x, y){[x - 1, y]}, # w
      ->(x, y){[x, y - 1]}, # s
      ->(x, y){[x + 1, y]}, # e

      ->(x, y){[x + 1, y + 1]}, # ne
      ->(x, y){[x - 1, y + 1]}, # nw
      ->(x, y){[x + 1, y - 1]}, # se
      ->(x, y){[x - 1, y - 1]}, # sw
    ]
  end
end

class KnightCounting < SimpleChessCounting
  def directions
    [
      ->(x, y){[x + 1, y + 2]}, # n
      ->(x, y){[x + 1, y - 2]}, # w
      ->(x, y){[x - 1, y + 2]}, # s
      ->(x, y){[x - 1, y - 2]}, # e

      ->(x, y){[x + 2, y + 1]}, # ne
      ->(x, y){[x + 2, y - 1]}, # nw
      ->(x, y){[x - 2, y + 1]}, # se
      ->(x, y){[x - 2, y - 1]}, # sw
    ]
  end
end

n = 5
counter = KnightCounting.new(n)
configurations = counter.each_position { |a, b| [a, b] }

(0..n**2).each do |c|
  max = 0
  puts "WITH #{c} PIECES!"
  configurations.combination(c).each do |config|
    move_count = counter.count_moves(config)
    if move_count >= max
      print config
      puts move_count
      max = move_count
    end
  end
end
