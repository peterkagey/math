require_relative "../helpers/table"

class OEIS

  # Table T(n,k) = 2^n + 2^k read by antidiagonals.
  def self.a271709(j)
    n, k = OEISTable.n_k(j)
    (1 << n) + (1 << k)
  end

end
