# This draws paths like
# ╭╮
# ╰╮ -OR-  ╭╮╭╮
# ╭╯        ╰╯
# Where at each step, the wanderer turns to the right or the left.
# Inspired by Project Euler problem 208:
# https://projecteuler.net/index.php?section=problems&id=208

# This class describes one "step" of the wanderer:
# The coordinates, turn-direction, and absolute direction.
class RobotLine
  NORTH = :north
  EAST  = :east
  WEST  = :west
  SOUTH = :south

  attr_reader :x, :y
  def initialize(x, y, relative_direction, objective_direction)
    @x = x
    @y = y
    @relative_direction = relative_direction
    @objective_direction = objective_direction
  end

  def normalize(min_x, min_y)
    RobotLine.new(@x - min_x, @y - min_y, @relative_direction, @objective_direction)
  end

  def to_s
    case [@relative_direction, @objective_direction]
    when [RobotPathDrawer::RIGHT, EAST] then "╭"
    when [RobotPathDrawer::LEFT, SOUTH] then "╭"

    when [RobotPathDrawer::RIGHT, SOUTH] then "╮"
    when [RobotPathDrawer::LEFT, WEST] then "╮"

    when [RobotPathDrawer::RIGHT, WEST] then "╯"
    when [RobotPathDrawer::LEFT, NORTH] then "╯"

    when [RobotPathDrawer::RIGHT, NORTH] then "╰"
    when [RobotPathDrawer::LEFT, EAST] then "╰"
    end
  end

  def next_line(left_or_right)
    a, b = next_coordinate
    RobotLine.new(a, b, left_or_right, next_objective_direction(left_or_right))
  end

  def next_coordinate
    case @objective_direction
    when NORTH then [@x + 1, @y]
    when EAST  then [@x, @y + 1]
    when WEST  then [@x, @y - 1]
    when SOUTH then [@x - 1, @y]
    end
  end

  def next_objective_direction(left_or_right)
    case @objective_direction
    when NORTH then left_or_right == RobotPathDrawer::RIGHT ? EAST  : WEST
    when EAST  then left_or_right == RobotPathDrawer::RIGHT ? SOUTH : NORTH
    when WEST  then left_or_right == RobotPathDrawer::RIGHT ? NORTH : SOUTH
    when SOUTH then left_or_right == RobotPathDrawer::RIGHT ? WEST  : EAST
    end
  end
end

# This draws a path based on a series of left or right steps,
# encoded as a binary string.
class RobotPathDrawer
  RIGHT = :right
  LEFT  = :left

  def relative_direction(s)
    case s
    when "0" then RIGHT
    when "1" then LEFT
    end
  end

  # seed is a string: "011001"
  def initialize(seed)
    @seed = seed
  end

  def initial_line
    initial_relative_direction = relative_direction(@seed[0])
    initial_absolute_direction = @seed[0] == "0" ? RobotLine::EAST : RobotLine::WEST
    RobotLine.new(0, 0, initial_relative_direction, initial_absolute_direction)
  end

  def determine_coordinates
    coordinates = @seed
      .split("")[1..-1]
      .reduce([initial_line]) { |lines, i| lines + [lines.last.next_line(relative_direction(i))] }
    normalize(coordinates)
  end

  def normalize(coordinates)
    min_x = coordinates.map(&:x).min
    min_y = coordinates.map(&:y).min
    coordinates.map { |c| c.normalize(min_x, min_y) }
  end

  def to_s
    canvas = []
    determine_coordinates
      .group_by { |c| [c.x, c.y] }
      .each do |c, lines|
        canvas[c[0]] ||= []
        if lines.map(&:to_s) != lines.map(&:to_s).uniq
          canvas[c[0]][c[1]] = "#"
        elsif lines.length == 1
          canvas[c[0]][c[1]] = lines.first.to_s
        else
          canvas[c[0]][c[1]] = "?"
        end
    end

    canvas
      .reverse
      .map { |a| a.map { |c| c || " "}.join }
      .join("\n")
    end
end

n = ARGV[0].to_i
x = (0...2**n).map { |i|
  # i.to_s(2).rjust(n, "0")
  RobotPathDrawer.new(i.to_s(2).rjust(n, "0"))
}
y = x.select { |i| !i.to_s.include?("#") }
y.each { |k| puts k, k.determine_coordinates.map(&:to_s).to_s, "\n" }
puts y.size
