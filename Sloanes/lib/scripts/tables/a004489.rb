require_relative "../helpers/table"
require_relative "../helpers/xor"

class OEIS

  def self.a004489(j)
    # This is a base-3 generalization of XOR where digits are added
    # place-wise mod 3.
    n, k = OEISTable.n_k(j)
    n.xor(k)
  end

end
