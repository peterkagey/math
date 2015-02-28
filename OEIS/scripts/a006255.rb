# http://oeis.org/A006255
require 'prime'
require_relative 'helpers/boolean_matrix'
require_relative 'helpers/is_square'

# Speed this up by making it halt as soon as a solution is found (instead of
# reducing the whole matrix).

class OEIS

  def self.a006255(n, opts = {})
    # Ron Graham's sequence
    seq =
      case
      when n == 2
        [2,3,6]
      when n == 3
        [3,6,8]
      when Prime.prime?(n)
        k = (n**0.5).floor
        [n, 2 * k**2, 2*n]
      when n.is_square?
        [n]
      else
        BooleanMatrix.construct(n).interpret
      end
      opts[:seq] ? seq : seq.last
  end

end
