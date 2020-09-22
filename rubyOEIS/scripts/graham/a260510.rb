require_relative 'a006255'
require_relative 'a248663'
require_relative '../helpers/boolean_matrix'

class OEIS
  # a(n) counts the number of sequences n = b_1 < b_2 < ... < b_t = A006255(n)
  # such that b_1*b_2*...*b_t is a perfect square.
  def self.a260510(n)
    ary = (n..a006255(n)).to_a.map{ |i| a248663(i) }
    BooleanMatrix.new(ary).dim_null_space - 1
  end

end
