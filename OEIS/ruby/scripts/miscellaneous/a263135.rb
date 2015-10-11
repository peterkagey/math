class A263135Builder

  # .           |            |     o o     .
  # .           |      o o   |  o o   o o  .
  # .    o o    |   o o   o  | o   o o   o .
  # .   o   o   |  o   o o   |  o o   o o  .
  # .    o o    |   o o      | o   o o   o .
  # .           |            |  o o   o o  .
  # .           |            |     o o     .
  # .           |            |             .
  # . f(6) = 6  | f(10) = 11 | f(24) = 30  .

  # The maximum number of penny-to-penny connections when pennies are placed on the vertices of a hexagonal tiling.

  # a(A033581(n)) = A152743(n)

  attr_reader :sequence

  def initialize(terms)
    @terms = terms
    @sequence = [0, 0,1,2,3,4,6]
    build_sequence
  end

  def build_derivative
    layers = Math.sqrt(@terms/6.0).ceil - 2
    @derivative = [3, 2, 2, 2, 2, 1]

    layers.times do |layer|
      1.times { @derivative += [2] + [1] * (layer + 0) }
      4.times { @derivative += [2] + [1] * (layer + 1) }
      1.times { @derivative += [2] + [1] * (layer + 2) }
    end
  end

  def build_sequence
    build_derivative
    @derivative.each do |i|
      i.times { @sequence << @sequence.last + 1 }
      @sequence << @sequence.last + 2
    end
  end

end

class OEIS

  A263135_SEQUENCE = A263135Builder.new(10000).sequence

  def self.a263135(n)
    A263135_SEQUENCE[n]
  end

end
