# This may only work for square tori. For a nonsquare torus, rotation hasn't been sorted out.
# It *might* work for nonsquare tori with coprime sides.
class TorusMaze

  attr_reader :key

  NE = "╱"
  NW = "╲"

  def initialize(n, m, key)
    throw "Key out of range!" if key >= (1<<(n*m))
    @width = n
    @height = m
    @key = key
  end

  def all_vertical_shifts # n
    current_key = @key
    [self] + (1...@height).map do |shift|
      last_lines = current_key >> @width
      first_line = current_key & ((1 << @width) - 1)
      current_key = last_lines + (first_line << (@width * (@height - 1)))
      TorusMaze.new(@width, @height, current_key)
    end
  end

  def row_keys
    Array.new(@height) { |i| @key >> (@width * i) & ((1 << @width) - 1) }.reverse
  end

  def shift_key
    rotated_rows = row_keys.map do |row_key|
      rotate_bit = row_key & 1
      (row_key >> 1) + (rotate_bit << (@width - 1))
    end
    TorusMaze.new(@width, @height, key_from_row_keys(rotated_rows))
  end

  def all_horizontal_shifts # n
    (1...@width).reduce([self]) do |mazes, maze|
      mazes << mazes.last.shift_key
    end
  end

  def key_from_row_keys(new_rows)
    new_rows.reduce { |accum, row| (accum << @width) + row }
  end

  def all_mirrors # 2
    mirrored_rows = row_keys.map do |row_key|
      (0...@width)
        .map { |i| 1 - row_key[i] }
        .reduce { |accum, i| (accum << 1) + i }
    end
    [self, TorusMaze.new(@width, @height, key_from_row_keys(mirrored_rows))]
  end

  def rotate
    matrix = row_keys
      .map { |row_key| (0...@width).map { |i| 1 - row_key[i] }}
      .transpose
      .reverse

    rotated_rows = matrix.map do |row_array|
      row_array.reverse.reduce { |accum, i| (accum << 1) + i }
    end

    TorusMaze.new(@width, @height, key_from_row_keys(rotated_rows))
  end

  def all_rotations #4
    return [self] if @width != @height

    [self, self.rotate, self.rotate.rotate, self.rotate.rotate.rotate]
  end

  def all_shifts # n^2
    all_horizontal_shifts.flat_map(&:all_vertical_shifts)
  end

  def all_rigid_motions # 4n^2
    @width == @height ? all_shifts.flat_map(&:all_rotations) : all_shifts
  end

  def all_symmetries # 8n^2
    all_rigid_motions.flat_map(&:all_mirrors)
  end

  def reflection_and_rotations
    all_rotations.flat_map(&:all_mirrors)
  end

  def to_s
    characters = Array.new(@height) do |j|
      Array.new(@width) do |i|
        @key[j*@width + i] == 0 ? NE : NW
      end
    end
    characters.map(&:join).join("\n")
  end

  def tile
    lines = to_s.split("\n")
    tiled = lines.zip(lines).map(&:join).zip(lines).map(&:join)
    (tiled * 3).join("\n")
  end
end

def all(n)
  counter = 0
  h = {}
  min_keys = []
  (0...(1<<(n**2))).each do |key|
    next if h[key]
    mazes = TorusMaze.new(n, n, key)
      .all_symmetries
      .map { |maze| h[maze.key] ||= maze }
      .uniq(&:key)

    min_key = mazes
      .map(&:key)
      .min

    # puts "Torus #{counter += 1}:"
    puts "#{mazes.length}\n\n"
    # mazes.each { |maze| puts maze.tile, "\n"}
    puts h[min_key].tile, "\n"

    min_keys << min_key
  end
  puts "number of mazes: #{min_keys.length}"
end

puts all(4)
