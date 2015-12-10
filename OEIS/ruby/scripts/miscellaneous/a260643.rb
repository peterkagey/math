# Ruby 2.1.4

class A260643Builder
  require 'set'
  attr_reader :seq

  def self.sequence(length = 10000)
    A260643Builder.new(length).seq
  end

  def initialize(length)
    @connections = Hash.new { |_, k| SortedSet.new [k] }
    @seq = []
    @new_neighbors = []
    length.times { extend_sequence }
  end

  private

  A080037_ARY = (1..10000).map { |n| n + ((4 * n - 3)**0.5).to_i + 2 }
  A080037 = SortedSet.new([0] + A080037_ARY)

  def a080037_inv; A080037.find_index(@seq.length + 1) end
  def a083479(n); n.nil? ? nil : n + 2 - ((4*n)**0.5).ceil end

  def extend_sequence
    update_connections_and_neighbors
    existing_connections = @new_neighbors.map { |i| @connections[i] }.reduce(:|)
    @seq << (1..Float::INFINITY).find { |i| !existing_connections.include?(i) }
  end

  def new_neighbors
    index = a083479(a080037_inv)
    [@seq.last] + [index ? @seq[index - 1] : nil].compact
  end

  def update_connections_and_neighbors
    @new_neighbors.each { |i| @connections[i] <<= @seq.last }
    @connections[@seq.last] += @new_neighbors
    refresh_neighbors
  end

  def refresh_neighbors; @new_neighbors = new_neighbors end

end

class OEIS

  A260643_SEQUENCE = A260643Builder.sequence

  def self.a260643(n)
    raise "sequence not defined for n = #{n} < 1" if n < 1
    A260643_SEQUENCE[n - 1] || A260643Builder.sequence(n).last
  end
end

# p (1..1000).map { |n| OEIS.a260643(n) }
