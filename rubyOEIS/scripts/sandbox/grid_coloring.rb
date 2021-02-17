class PairComparison
  def self.neighbors(known_coloring)
    horizontal_neighbors(known_coloring) + vertical_neighbors(known_coloring)
  end

  # Look at all tiles from the second row onward, and take the tile above them.
  def self.vertical_neighbors(known_coloring)
    (1...known_coloring.length).flat_map do |i|
      known_coloring[i]
        .each_with_index
        .map { |tile, j| [known_coloring[i - 1][j], tile].sort }
    end
  end

  def self.horizontal_neighbors(known_coloring)
    known_coloring
      .flat_map { |letters| letters.zip(letters[1..-1])[0...-1] }
      .map(&:sort)
  end
end

class PartialGrid
  def self.initial(n, x, y)
    PartialGrid.new(n, x, y, [0, 0], [[1]])
  end

  def to_s
    @known_coloring
      .map(&:to_s)
      .join("\n")
  end

  def update(cursor, coloring)
    PartialGrid.new(@n, @x, @y, cursor, coloring)
  end

  def initialize(n, x, y, cursor, known_coloring)
    @n = n
    @x = x
    @y = y

    @cursor = cursor
    @known_coloring = known_coloring
  end

  def valid_state?
    adjacencies = PairComparison.neighbors(@known_coloring)
    adjacencies == adjacencies.uniq
  end

  def finished?
    @cursor == [@y - 1, @x - 1] && valid_state?
  end

  def next

    if finished?
      throw "Already Finished!"
    elsif valid_state?
      append_new_label
    else
      revise_existing_labels
    end
  end

  def last_term_is_biggest?
    terms = @known_coloring.flatten
    last_term = terms.last
    terms[0...-1].all? { |i| i < last_term }
  end

  def revise_existing_labels
    a, b = @cursor
    throw "No valid coloring!" if @cursor == [0, 0]
    if @known_coloring[a][b] < @n && !last_term_is_biggest?
      @known_coloring[a][b] += 1 # mutates
      self
    else
      drop_and_increment
    end
  end

  private

  # Mutates
  def drop_and_increment
    a, b = @cursor
    @cursor = b == 0 ? [a - 1, @x - 1] : [a, b - 1] # mutates
    @known_coloring[a].pop # mutates
    @known_coloring.pop if @known_coloring.last.empty? # mutates
    revise_existing_labels
  end

  # Append a new color
  def append_new_label
    a, b = @cursor
    new_cursor = b + 1 <= @x - 1 ? [a, b + 1] : [a + 1, 0]
    update(new_cursor, append_color)
  end

  # Mutates
  def append_color
    a, b = @cursor
    @known_coloring[a] ||= []
    @known_coloring[a] << 1
    @known_coloring
  end
end

n = ARGV[0].to_i
x = ARGV[1].to_i
y = ARGV[2].to_i

grid = (1..Float::INFINITY)
  .reduce(PartialGrid.initial(n, x, y)) { |state, _| state.finished? ? (break state) : state.next}

puts grid
# a(2, 2) = 3 via
# [1, 1]
# [2, 3]

# a(3, 3) = 5 via
# [1, 1, 2]
# [3, 4, 2]
# [3, 5, 5]

# a(4, 4) = 7 via
# [1, 1, 2, 2]
# [3, 4, 4, 5]
# [2, 6, 7, 1]
# [7, 3, 5, 6]

# a(5, 5) = 9 via
# [1, 1, 2, 2, 3]
# [3, 4, 4, 5, 3]
# [6, 6, 7, 1, 8]
# [9, 2, 7, 9, 8]
# [4, 8, 5, 5, 6]

# a(6, 6) <= 11
# [1,  1, 2,  2,  3,  1]
# [4,  5, 5,  6,  3,  7]
# [2,  7, 8,  1,  9,  4]
# [8,  9, 10, 10, 11, 6]
# [6,  9, 5,  3,  11, 7]
# [10, 2, 11, 8,  4, 10]

# a(7, 7) <= 13
# [1, 1, 2, 2, 3, 1, 4]
# [5, 6, 4, 5, 3, 7, 4]
# [5, 7, 8, 8, 6, 2, 9]
# [9, 7, 10, 1, 9, 8, 3]
# [9, 11, 2, 12, 10, 11, 4]
# [12, 3, 13, 13, 5, 11, 13]
# [4, 10, 10, 6, 12, 12, 7]

# a(8, 8) <= 15
# [1, 1, 2, 2, 3, 1, 4, 2]
# [5, 6, 6, 7, 3, 8, 4, 5]
# [3, 4, 9, 1, 10, 2, 11, 5]
# [6, 10, 5, 12, 7, 9, 3, 13]
# [8, 8, 7, 4, 13, 8, 12, 2]
# [5, 14, 7, 15, 1, 11, 6, 14]
# [15, 9, 11, 10, 14, 11, 15, 14]
# [12, 9, 13, 10, 12, 12, 13, 13]
