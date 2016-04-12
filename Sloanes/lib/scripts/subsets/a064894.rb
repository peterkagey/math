require_relative '../helpers/subset_logic'

class OEIS
  def self.a064894(n)
    Subset.zero_indexed(n).reduce(0, :gcd)
  end
end
