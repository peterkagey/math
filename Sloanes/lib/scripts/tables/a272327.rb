require_relative "../helpers/table"

class OEIS
  # Table read by antidiagonals: T(n, k) is the least i > n such that
  # n divides i^k (n > 0, k > 0).
  def self.a272327(j)
    raise "A272327 is not defined for n = #{j} < 1" if j < 1
    n, k = OEISTable.n_k(j - 1).map(&:next)
    (n + 1..2 * n).find { |i| i**k % n == 0 }
  end

end
