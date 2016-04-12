require_relative "../helpers/table"

class OEIS

  # Table T(n,k) = 2^n XOR 2^k read by antidiagonals, where XOR is the binary exclusive or operator.
  def self.a271710(j)
    n, k = OEISTable.n_k(j)
    (1 << n) ^ (1 << k)
  end

end
