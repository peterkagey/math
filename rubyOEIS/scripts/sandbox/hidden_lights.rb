require 'set'

#                                                                       .
#                                                       .              . o
#                                         .            . o            o . o
#                            .           . .          . . o          . o o .
#               .           . .         . o o        o o o .        o o . o .
#  .           . .         . o o       o o . o      o o o o .      o . o . o o
# . .         . o o       . o o o     o . . o o    o . . . o o    o . o . o o o
#
# a(2) = 3    a(3) = 4    a(4) = 5    a(5) = 7     a(6) = 9       a(7) = 11

class Subset
  def self.from_index(underlying_set, index)
    throw "index is too big: #{index}" if index.bit_length > underlying_set.size
    (0...index.bit_length)
      .select { |i| index[i] == 1 }
      .map { |i| underlying_set[i] }
      .to_set
  end
end

class Mask
  def self.from_index(triangle_game, mask_number)
    Mask.new(
      triangle_game,
      Subset.from_index(triangle_game.coordinates, mask_number)
    )
  end

  def initialize(triangle_game, coordinates)
    @game = triangle_game
    @coordinates = triangle_game.coordinate_set - coordinates
  end

  def to_s
    board_size = @game.board_size
    drawing = Array.new(board_size) { |i| Array.new(i + 1, ".") }
    @coordinates.each { |i, j| drawing[i - 1][j - 1] = "o" }

    drawing
      .each_with_index
      .map { |row, i| " " * (board_size - i) + row.join(" ") }
      .join("\n")
  end

  def valid_board?
    histogram = Set.new
    @game.coordinates.each do |a, b|
      @game.triangles_for(a, b).each do |vertices|
        key = vertices.select { |v| @coordinates.include?(v) }.sort
        return false if histogram.include?(key)
        histogram << key
      end
    end
    true
  end

  def cross_out_count
    @coordinates.length
  end

end

class TriangleGame

  attr_reader :board_size, :coordinates, :coordinate_set

  def initialize(board_size)
    @board_size = board_size
    @coordinates = compute_coordinates
    @coordinate_set = Set.new(compute_coordinates)
  end

  def compute_coordinates
    (1..@board_size).flat_map do |i|
      (1..i).map { |j| [i, j] }
    end
  end

  def coordinate_count
    triangle_number = ->(n) { n * (n + 1)/2 }
    (1 << triangle_number[@board_size]) - 1
  end


  # Coordinate scheme: (matrix)
  # (1, 1)
  # (2, 1) (2, 2)
  # (3, 1) (3, 2) (3, 3)
  def triangles_for(a, b)
    if a > @board_size || b > a
      throw "Invalid coordinate (#{a}, #{b}) for board size #{@board_size}!"
    end

    (a + 1..@board_size).map do |row_index|
      [
        [a, b],
        [row_index, b],
        [row_index, b + row_index - a]
      ]
    end
  end
end

board_size = 8
game = TriangleGame.new(board_size)

# masks = board_size * (board_size + 1)/2
# puts (0...1 << masks)
#   .map { |mask_number| Mask.from_index(game, mask_number) }
#   .select(&:valid_board?)
#   .sort_by(&:cross_out_count)
#   .each_with_index
#   .map { |mask, i| "#{i + 1}:  \n" + mask.to_s + "\n" * 2}

(1..Float::INFINITY).flat_map do |subset_size|
  x = game
    .coordinates
    .combination(subset_size)
    .lazy
    .map { |ss| Mask.new(game, ss) }
    .find { |mask| mask.valid_board? }
    puts x
  break if x.nil?
end
#
# p y
