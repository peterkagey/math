require_relative 'helpers/is_square'
require_relative 'a067565'

class OEIS

  # Number of iterations of A067565 required to reach a perfect square.
  def self.a255980(n)
    c = 0
    n = a067565(n) while n.is_nonsquare? && c += 1
    c
  end

end
