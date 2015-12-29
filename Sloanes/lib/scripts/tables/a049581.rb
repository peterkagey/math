require_relative "../helpers/table"

class OEIS

  def self.a049581(j)
    n, k = OEISTable.n_k(j)
    (n - k).abs
  end

end
