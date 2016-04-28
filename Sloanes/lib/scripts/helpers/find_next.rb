class Array

  def find_next(&block)
    (self.last + 1...Float::INFINITY).find { |i| yield(i) }
  end

end
