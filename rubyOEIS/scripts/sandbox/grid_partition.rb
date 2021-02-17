# The idea, how many partitions of the n X n grid are needed to prevent any
# three tiles in the same partition from laying on the same line?
class GridPartition

  attr_reader :r_i, :c_i, :state

  Tile = Struct.new(:row_index, :column_index, :value) {
    # width corresponds to the max column index
    # height corresponds to the max row index
    def next_position(height, width)
      if column_index < width - 1
        [row_index, column_index + 1]
      elsif row_index < height - 1
        [row_index + 1, 0]
      else
        throw "No next tile: #{[row_index, column_index]}"
      end
    end

    def previous_position(height, width)
      if column_index > 0
        [row_index, column_index - 1]
      elsif row_index > 0
        [row_index - 1, width - 1]
      else
        throw "No previous tile: #{[row_index, column_index]}"
      end
    end
  }

  def self.initial_board(width, height, partitions)
    board = Array.new(width) { |_| Array.new(height) }
    board[0][0] = 1
    GridPartition.new(partitions, board, Tile.new(0, 0, 1))
  end

  def initialize(partitions, state, current_tile)
    @partitions = partitions
    @state = state
    @width = @state.first.length
    @height = @state.length
    @current_tile = current_tile
  end

  def to_s
    @state
      .map { |row| row.map { |t| t || "_"}.join(" ") }
      .join("\n")
      .to_s
  end

  def append
    row_index, column_index = @current_tile.next_position(@height, @width)
    @state[row_index][column_index] = 1
    GridPartition.new(@partitions, @state, Tile.new(row_index, column_index, 1))
  end

  def r_i; @current_tile.row_index end
  def c_i; @current_tile.column_index end

  def increment
    if @current_tile.value == @partitions
      @state[r_i][c_i] = nil
      row_index, column_index = @current_tile.previous_position(@height, @width)
      previous_state = @state[row_index][column_index]
      GridPartition.new(@partitions, @state, Tile.new(row_index, column_index, previous_state)).increment
    else
      @state[r_i][c_i] = @current_tile.value + 1
      new_tile = Tile.new(r_i, c_i, @current_tile.value + 1)
      GridPartition.new(@partitions, @state, new_tile)
    end
  end

  def legal_substate?
    current_row = @state[r_i]
    current_column = (0...@height).map { |row_index| @state[row_index][c_i] }

    nw_steps = [r_i, c_i].min
    current_nw_diagonal = (0..nw_steps).map { |s| @state[r_i - s][c_i - s]}

    ne_steps = [r_i, @width - c_i - 1].min
    current_ne_diagonal = (0..ne_steps).map { |s| @state[r_i - s][c_i + s] }

    current_row.count(@current_tile.value) < 3 &&
    current_column.count(@current_tile.value) < 3 &&
    current_nw_diagonal.count(@current_tile.value) < 3 &&
    current_ne_diagonal.count(@current_tile.value) < 3
  end

  def advance
    legal_substate? ? append : increment
  end

  def completed?
    legal_substate? && r_i == @height - 1 && c_i == @width - 1
  end

  def first_solution
    starting_place = self.completed? ? self.increment : self
    progress = (2..Float::INFINITY).inject(starting_place) do |current, i|
      return current if current.completed?
      x = current.advance
      # puts i, x, "\n"
      x
    end
    puts "~" * 50
    puts progress
    throw "Something went wrong!"
  end
end


i = 8
(1..3000).inject(GridPartition.initial_board(i, i, 4)) do |accum, k|
  x = accum.first_solution
  puts k, x, "\n"
  x
end
