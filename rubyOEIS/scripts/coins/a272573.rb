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

  # "k" is the name of a special hexagonal index that is on a "main diagonal"
  # of the spiral. The second optional parameter "steps down" the spoke toward
  # the center by b steps.
  # This function will always be less than or equal to @index.
  def k_on_spoke(i, b = 0)
    SPOKES[i].call(INVERSES[i].call(@index) - b)
  end

  # This function gives the spoke-index of the spoke nearest to @index
  def spoke_index
    @max_k ||= (0...6).map { |i| k_on_spoke(i) }.max
    @spoke_index ||= (0...6).find { |i| k_on_spoke(i) == @max_k }
  end

  def neighbors
    return [ ] if @index == 1
    return [1] if @index == 2

    neighbors = [@index - 1, k_on_spoke(spoke_index, 1) + (@index - @max_k)]
    neighbors << neighbors.last - 1 if @index != @max_k
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
