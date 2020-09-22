require_relative "../helpers/remainder_game"
require_relative "../helpers/table"

class OEIS

  # Similar to A268057
  def self.a107435(i)
    raise "A107435 is not defined for n = #{i}" if i < 1
    n, k = OEISTable.n_k(i - 1)
    RemainderGame.euclid(n + k + 1, k + 1)
  end

end
