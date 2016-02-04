class Array
  def cumulative_sum
    sum = 0
    self.map { |i| sum += i }
  end

  def first_differences
    self.each_cons(2).map { |a, b| b - a }
  end
end
