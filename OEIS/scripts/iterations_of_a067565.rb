require_relative 'helpers/is_square'
require_relative 'a067565'

class OEIS

  def self.iterations(n)
    # number of iterations of A067565 (inverse Graham's sequence) to reach a
    # perfect square.
    counter = 0
    # n.is_square? ? (return counter) : n = a067565(n) while counter += 1
    n = a067565(n) while n.is_nonsquare? && counter += 1
    counter
  end

end
