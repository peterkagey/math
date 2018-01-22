class Subset
  def self.one_indexed(n)
    zero_indexed(2 * n)
  end

  def self.zero_indexed(n)
    (0...n.bit_length).select { |i| n[i] != 0 }
  end
end

class Range
  def map_subsets(&block); to_a.map_subsets { |i| yield(i) } end
end

class Array

  def count_subsets(&block)
    counter = 0
    each_subset { |i| counter += 1 if yield(i) }
    counter
  end

  def each_subset(&block)
    (0...2**length).each { |i| yield(subset(i)) }
  end

  def map_subsets(&block)
    (0...2**length).map { |i| yield(subset(i)) }
  end

  private
  # [1,2,3].subset(0b0)   => []
  # [1,2,3].subset(0b1)   => [1]
  # [1,2,3].subset(0b10)  => [2]
  # [1,2,3].subset(0b11)  => [1,2]
  # [1,2,3].subset(0b100) => [3]
  # [1,2,3].subset(0b101) => [1,3]
  # [1,2,3].subset(0b110) => [2,3]
  # [1,2,3].subset(0b111) => [1,2,3]
  def subset(index)
    (0...index.bit_length).select { |i| index[i] == 1 }.map { |i| self[i] }
  end

end
