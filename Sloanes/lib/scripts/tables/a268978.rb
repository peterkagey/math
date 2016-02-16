require_relative '../helpers/n_choose_k'
require_relative "../helpers/table"

class PascalsTriangle
  def self.builder(rows = 10)
    rows.times.collect do |n|
      (0..n).map { |k| n.choose(k) }
    end
  end
end


class OEIS

  PASCALS_TRIANGLE = PascalsTriangle.builder(141)

  def self.a268978_table(n, k)
    PASCALS_TRIANGLE[0...n].flatten.count { |i| i % k == 0 }
  end

  def self.a268978(i)
    raise "A268978 is not defined for n = #{i}" if i < 1
    n, k = OEISTable.n_k(i - 1)
    # n >= 1  and  1 <= k <= n
    OEIS.a268978_table(n + k + 1, k + 1)
  end

end
