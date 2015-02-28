require_relative 'helpers/is_square'
require_relative 'a067565'

class OEIS

  def self.iterations(n)
    # number of iterations of A067565 (inverse Graham's sequence) to reach a
    # perfect square.
    counter = -1
    # n.is_square? ? (return counter) : n = a067565(n) while counter += 1
    while counter += 1
      return counter if n.is_square?
      n = a067565(n)
    end
  end

end
