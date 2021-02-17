# a = %w[│ ─ ┼ ╭ ╮  ╯ ╰]

# b = %w[│ ─ ├ ┤ ┼ ┴ ┐ ┌ ┘ └ ┬]

# c = %w[╱ ╲]

# d = %w[│ ─]

# n = 2

# n.times { puts (Array.new(50) { c.sample }.join) }

class MazeBuilder

  LINES = %w[╱ ╲]

  attr_accessor :maze

  def self.random_maze(x, y)
    MazeBuilder.new(Array.new(x) { Array.new(y) { [LINES.sample, nil] } })
  end

  def initialize(array_of_arrays)
    @maze = array_of_arrays
  end

  def entry(x, y)
    @maze[x][y].first
  end

  def set_entry(x,y,value)
    @maze[x][y][0] = value
  end

  def neighbors(x, y)
    max_x = @maze.length - 1
    max_y = @maze.first.length - 1
    neighbors = Array.new(8)
    neighbors[0] = [x - 1, y]     unless x == 0                   # N
    neighbors[1] = [x - 1, y - 1] unless x == 0     || y == 0     # NW
    neighbors[2] = [x,     y - 1] unless               y == 0     # W
    neighbors[3] = [x + 1, y - 1] unless x >= max_x || y == 0     # SW
    neighbors[4] = [x + 1, y]     unless x >= max_x               # S
    neighbors[5] = [x + 1, y + 1] unless x >= max_x || y >= max_y # SE
    neighbors[6] = [x,     y + 1] unless               y >= max_y # E
    neighbors[7] = [x - 1, y + 1] unless x == 0     || y >= max_y # NE
    neighbors
  end

  def to_s
    @maze.map { |row| row.map(&:first).join }.join("\n")
  end

end

class MazeAnalyzer

  def initialize(maze)
    @maze = maze
    # @maze.maze[0][0] = ['X', nil]
    puts @maze
    chain = connected_chain(0,0)
    puts "*" * 3 + "#{chain.length}" + "*" * 3
    chain.each do |neighbor|
      x_0, y_0 = neighbor
      @maze.set_entry(x_0, y_0, 'x')
    end
    puts @maze
  end

  def connected_neighbors(x, y)
    neighbors = @maze.neighbors(x, y)
    connected = []
    neighbors.each_with_index do |neighbor, index|
      next if neighbor.nil?
      if index % 2 == 1
        next
      end
      x_0, y_0 = neighbor
      begin
        if @maze.entry(x_0, y_0) != @maze.entry(x,y)
          connected << neighbor
        end
      rescue
        puts " ^ " * 100
        p [[x, y], [x_0, y_0]]
        puts " ^ " * 100
      end

    end
    connected
  end

  def connected_chain(x,y)
    connected_chain = [[0,0]]
    (0...20).each do |i|
      connected_chain.each do |coord|
        x_0, y_0 = coord
        connected_chain += connected_neighbors(x_0, y_0)
      end
      connected_chain = connected_chain.uniq
    end
    connected_chain

  end

  def to_s
    @maze.to_s
  end

end

x = (ARGV[0] || 25).to_i
y = (ARGV[1] || 50).to_i
puts MazeBuilder.random_maze(x, y)
