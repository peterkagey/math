# Start out moving one unit to the right.

class VerticalStep < Step
  attr_reader :x, :y_1, :y_2
  def initialize(x, y_1, y_2)
    @x = x
    @y_1 = y_1
    @y_2 = y_2
  end

  def self.new_paths(path)
    [
      path + [VerticalStep.up(path)],
      path + [VerticalStep.down(path)]
    ]
  end

  def self.up(path)
    initial_position = path.last.
  end

  def self.from(horizontal_step, length)
    if horizontal_step.class != HorizontalStep
      throw "Vertical Step can only be built from a horizontal path!"
    end
    VerticalStep.new(
      horizontal_step.x_2,
      horizontal_step.y,
      horizontal_step.y + length
    )
  end

  def to_s
    "\\draw (#{x}, #{y_1})--(#{x},#{y_2});"
  end
end

class HorizontalStep < Step
  attr_reader :y, :x_1, :x_2
  def initialize(y, x_1, x_2)
    @y = y
    @x_1 = x_1
    @x_2 = x_2
  end

  def self.from(vertical_step, length)
    if vertical_step.class != VerticalStep
      throw "Horizonal Step can only be built from a vertical path!"
    end
    HorizontalStep.new(
      vertical_step.y_2,
      vertical_step.x,
      vertical_step.x + length
    )
  end

  def shorten(paths)
  end

  def to_s
    "\\draw (#{x_1}, #{y})--(#{x_2},#{y});"
  end
end

def

def new_step(path)
  if path.last.class == HorizontalStep
    [
      path + [VerticalStep.from(path.last, 1)],
      path + [VerticalStep.from(path.last, -1)],
    ]
  elsif path.last.class == VerticalStep
    [
      path + [HorizontalStep.from(path.last, 1).shorten(path[0...-1])],
      path + [HorizontalStep.from(path.last, -1).shorten(path[0...-1])],
    ]
  else
    throw "I fell through: #{paths.last.class}"
  end
end

paths = [
  [HorizontalStep.new(0, 0, 1)]
]
(1..2).each do |i|
  paths = paths.flat_map { |path| new_step(path) }
end
paths.each { |path| puts path, "\n\n\n"}
