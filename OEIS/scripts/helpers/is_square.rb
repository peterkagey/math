class Integer
  def is_square?
    k = (self**0.5).round
    k**2 == self
  end
end
