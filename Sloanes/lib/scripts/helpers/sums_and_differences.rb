class Array
  def cumulative_sum
    sum = 0
    self.map { |i| sum += i }
  end

  def first_differences
    self.each_cons(2).map { |a, b| b - a }
  end

  def run_lengths
    (1...length).inject([1]) do |accum, i|
      self[i] == self[i - 1] ? accum[0...-1] << accum[-1] + 1 : accum << 1
    end
  end
end
