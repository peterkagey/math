require_relative "../helpers/table"
require_relative "../helpers/xor"

class OEIS

  def self.a004489(j)
    n, k = OEISTable.n_k(j)
    n.xor(k)
  end

end
