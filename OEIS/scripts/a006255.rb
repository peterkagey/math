# http://oeis.org/A006255
require 'prime'
require_relative 'boolean_matrix'

# Speed this up by making it halt as soon as a solution is found (instead of
# reducing the whole matrix).

class OEIS

  def self.a006255(n, opts = {})
    # Ron Graham's sequence
    seq =
      case
      when n == 2 then [2,3,6]
      when n == 3 then [3,6,8]
      when Prime.prime?(n)
        k = (n**0.5).floor
        [n, 2 * k**2, 2*n]
      when (n**0.5).round**2 == n then [n]
      else
        BooleanMatrix.construct(n).interpret
      end
      opts[:seq] ? seq : seq.last
  end

end
