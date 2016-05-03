class Spokes

  def initialize(index)
    @index = index
  end

  SPOKES = [
    ->(n) { 3 * n**2 - 2 * n + 1 },
    ->(n) { 3 * n**2 -     n + 1 },
    ->(n) { 3 * n**2         + 1 },
    ->(n) { 3 * n**2 +     n + 1 },
    ->(n) { 3 * n**2 + 2 * n + 1 },
    ->(n) { 3 * n**2 + 3 * n + 2 },
  ]

  INVERSES = [
    ->(k) { (Math.sqrt(3  * k - 2 ) + 1).to_i/3 },
    ->(k) { (Math.sqrt(12 * k - 11) + 1).to_i/6 },
    ->(k) { (Math.sqrt(3  * k - 3 )    ).to_i/3 },
    ->(k) { (Math.sqrt(12 * k - 11) - 1).to_i/6 },
    ->(k) { (Math.sqrt(3  * k - 2 ) - 1).to_i/3 },
    ->(k) { (Math.sqrt(12 * k - 15) - 3).to_i/6 },
  ]

  def spokify(i, b = 0)
    SPOKES[i].call(INVERSES[i].call(@index) - b)
  end

  def last_spoke_value
    @spoke_value ||= (0...6).map { |i| spokify(i) }.max
  end

  def last_spoke_index
    @spoke_index ||= (0...6).find { |i| spokify(i) == last_spoke_value }
  end

  def neighbors
    return [ ] if @index == 1
    return [1] if @index == 2

    neighbors = [
      @index - 1,
      spokify(last_spoke_index, 1) + (@index - last_spoke_value)
    ]

    neighbors << neighbors.last - 1 if @index != last_spoke_value
    neighbors
  end

end

class A272573Builder
  require 'set'
  attr_reader :seq

  def self.sequence(length = 10)
    A272573Builder.new(length).seq
  end

  def initialize(length)
    @connections = Hash.new { |_, k| SortedSet.new [k] }
    @seq = [1]
    @new_neighbors = []
    (1...length).each { extend_sequence }
  end

  private

  def extend_sequence
    update_connections_and_neighbors
    existing_connections = @new_neighbors.map { |i| @connections[i] }.reduce(:|)
    @seq << (1..Float::INFINITY).find { |i| !existing_connections.include?(i) }
  end

  def update_connections_and_neighbors
    @new_neighbors.each { |i| @connections[i] << @seq.last }
    @connections[@seq.last] += @new_neighbors
    refresh_neighbors
  end

  def new_neighbors; Spokes.new(@seq.length + 1).neighbors.map { |i| @seq[i - 1] } end
  def refresh_neighbors; @new_neighbors = new_neighbors end

end

class OEIS

  A272573_SEQUENCE = A272573Builder.sequence

  def self.a272573(n)
    raise "sequence not defined for n = #{n} < 1" if n < 1
    A272573_SEQUENCE[n - 1] || A272573Builder.sequence(n)[-1]
  end
end
