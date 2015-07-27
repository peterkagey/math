require_relative 'a006255'
require_relative '../helpers/subset_logic'
require_relative '../helpers/perfect_square_product'

class OEIS
  # a(n) counts the number of sequences n = b_1 < b_2 < ... < b_t = A006255(n)
  # such that b_1*b_2*...*b_t is a perfect square.
  def self.a259527(n)
    ary = (n..a006255(n)).to_a.map{ |i| a248663(i) }
    2**(BooleanMatrix.new(ary).dim_null_space - 1)
  end

end
