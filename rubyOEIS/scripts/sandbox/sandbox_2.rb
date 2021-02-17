# A260643   Start a spiral of numbers on a square grid, with the initial square
# as a(1) = 1. a(n) is the smallest positive integer not equal to or previously
# adjacent (horizontally/vertically) to its neighbors. See the Comments section
# for a more exact definition.

class Point
  attr_reader :x, :y
  attr_accessor :value
  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "(#{x}, #{y})"
  end
end

class SquareCoords

  attr_reader :array

  def initialize
    @array = [Point.new(0, 0)]
    @direction = :right
    @steps = 1
    build_array!
  end

  def change_direction
    case @direction
    when :right then @direction = :up
    when :up    then @direction = :left
    when :left  then @direction = :down
    when :down  then @direction = :right
    end
  end

  def next_point
    x, y = [@array.last.x, @array.last.y]
    case @direction
    when :right then Point.new(x + 1, y)
    when :up    then Point.new(x, y + 1)
    when :left  then Point.new(x - 1, y)
    when :down  then Point.new(x, y - 1)
    end
  end

  def build_array!
    until @array.length > 100 do
      @steps.times { @array << next_point }
      change_direction
      @steps.times { @array << next_point }
      change_direction
      @steps += 1
    end
  end

  def to_s
    @array.map(&:to_s).join(", ")
  end

  def neighbor?(point, point_2)
    x_1 = point.x
    y_1 = point.y
    x_2 = point_2.x
    y_2 = point_2.y
    case
    when x_1 == x_2 then [y_1 - 1, y_1 + 1].include?(y_2)
    when y_1 == y_2 then [x_1 - 1, x_1 + 1].include?(x_2)
    else
      false
    end
  end

  def neighbors(point)
    @array.select { |coord| neighbor?(point, coord) }
  end

  def neighbor_values(point)
    neighbors(point).select(&:value).map(&:value)
  end

end

class SequenceBuilder

  attr_reader :seq

  INF = 1.0/0.0

  def initialize
    @helper = SquareCoords.new
    @array = @helper.array
    @relationships = Hash.new { |h, k| h[k] = [k] }
    @seq = []
    start = Time.now
    build!
    Time.now - start
  end

  def build!
    @array.each do |point|
      neighbor_values = @helper.neighbor_values(point)
      # least i such that @relationships[i] has no overlaps with neighbor_values(point)
      value = (1..INF).find { |i| neighbor_values & @relationships[i] == [] }
      raise "No value found" if value.nil?
      seq << value
      point.value = value
      @relationships[value] += neighbor_values
      neighbor_values.each { |val| @relationships[val] << value }
    end
  end

end

connections = Hash.new { |key| [key] }

p SequenceBuilder.new.seq
