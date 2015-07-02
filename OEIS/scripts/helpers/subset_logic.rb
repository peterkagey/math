class Array

  def count_subsets(&block)
    counter = 0
    each_subset { |i| counter += 1 if yield(i) }
    counter
  end

  def each_subset(&block)
    (0...2**length).each { |i| yield(subset(i)) }
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
    sub_array = []
    (0...index.bit_length).each { |j| sub_array << self[j] if index[j] == 1 }
    sub_array
  end

end
