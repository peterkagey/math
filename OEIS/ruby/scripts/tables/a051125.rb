require_relative "../helpers/table"

class OEIS

  def self.a051125(j)
    raise "A051125 is not defined for n = #{j}" if j < 1
    n, k = OEISTable.n_k(j - 1)
    [n, k].max
  end

end
