# http://oeis.org/A006255
require 'prime'
require_relative 'a248663'
require_relative 'boolean_matrix'
class OEIS

  def self.a006255(n, opts = {})
    # Ron Graham's sequence
    #
    seq = 
      case n
      when 1 then [1]
      when 2 then [2,3,6]
      when 3 then [3,6,8]
      else
        BooleanMatrix.construct(n).interpret
      end
      opts[:seq] ? seq : seq.last
  end

end
