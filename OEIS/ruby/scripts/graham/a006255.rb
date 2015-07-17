# http://oeis.org/A006255
require 'prime'
require_relative '../helpers/boolean_matrix'
require_relative '../helpers/is_square'

class OEIS

  # Ron Graham's sequence: a(n) = smallest m for which there is a sequence
  # n = b_1 < b_2 < ... < b_t = m such that b_1*b_2*...*b_t is a perfect square.
  def self.a006255(n, opts = {})
    seq = a006255_seq(n)
    opts[:seq] ? seq : seq.last
  end

  def self.a006255_seq(n)
    return [2,3,6] if n == 2
    return [3,6,8] if n == 3
    return [n]     if n.is_square?
    return [n, 2 * ((n**0.5).floor)**2, 2*n] if Prime.prime?(n)
    BooleanMatrix.construct(n).interpret
  end
  private_class_method :a006255_seq

end
