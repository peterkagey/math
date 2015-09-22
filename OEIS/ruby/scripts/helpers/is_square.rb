class SquareLookup

  MAX = 10000

  def self.squarefree_numbers
    squares = (2..MAX**0.5).to_a.map { |i| i**2 }
    bool_ary = Array.new(10001) { true }
    bool_ary[0] = false
    squares.each do |square|
      (1..MAX/square).count { |i| bool_ary[square * i] = false}
    end
    bool_ary
  end

  def self.squares
    bool_ary = Array.new(10001) { false }
    squares = (0..MAX**0.5).each { |i| bool_ary[i**2] = true }
    bool_ary
  end

end

class Integer

  SQUAREFREE = SquareLookup.squarefree_numbers
  SQUARE = SquareLookup.squares

  def is_square?
    return SQUARE[self] if self <= 10_000 && self >= 0
    k = (self**0.5).round
    k**2 == self
  end

  def is_nonsquare?
    !is_square?
  end

  def is_squarefree?
    return SQUAREFREE[self] if self <= 10_000 && self >= 0
    raise "Input is out of range! (#{n} is not in (0..10_000)"
  end

  def is_nonsquarefree?
    return !SQUAREFREE[self] if self <= 10_000 && self >= 0
    raise "Input is out of range! (#{n} is not in (0..10_000)"
  end

end
