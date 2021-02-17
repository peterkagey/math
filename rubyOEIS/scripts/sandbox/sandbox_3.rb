class CoordLister

  attr_reader :list

  def self.each_coord
    self.new.list.each { |i| yield(i) }
  end

  def initialize
    @list = [[0,0]]
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
    x, y = @list.last
    case @direction
    when :right then [x + 1, y]
    when :up    then [x, y + 1]
    when :left  then [x - 1, y]
    when :down  then [x, y - 1]
    end
  end

  def build_array!
    until @list.length > 1000 do
      @steps.times { @list << next_point }
      change_direction
      @steps.times { @list << next_point }
      change_direction
      @steps += 1
    end
  end

end

class SequenceBuilder

  attr_reader :seq

  INF = 1.0/0.0

  def initialize
    @values = {}
    @relationships = Hash.new { |h, k| h[k] = [k] }
    @seq = []
    start = Time.now
    build!
    Time.now - start
  end

  def neighbor_values(point)
    x, y = point
    points = [
      [x + 1, y],
      [x, y + 1],
      [x - 1, y],
      [x, y - 1]
    ]
    points.map { |point| @values[point] }.compact
  end

  def build!
    CoordLister.each_coord do |point|
      neighbor_values = neighbor_values(point)

      # least i such that @relationships[i] has no overlaps with neighbor_values(point)
      value = (1..INF).find { |i| neighbor_values & @relationships[i] == [] }
      raise "No value found" if value.nil?

      seq << value
      @values[point] = value
      @relationships[value] += neighbor_values
      neighbor_values.each { |val| @relationships[val] << value }
    end
  end

end

start = Time.now;
p SequenceBuilder.new.seq;
p Time.now - start
