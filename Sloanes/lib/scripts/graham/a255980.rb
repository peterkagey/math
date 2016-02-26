require_relative '../helpers/is_square'
require_relative 'a067565'

class OEIS

  # Number of iterations of A067565 required to reach a perfect square.
  def self.a255980(n)
    (0..Float::INFINITY).inject(n) do |k, c|
      k.is_nonsquare? ? a067565(k) : (return c)
    end
  end

end
