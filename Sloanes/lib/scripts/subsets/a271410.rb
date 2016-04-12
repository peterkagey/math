require_relative '../helpers/subset_logic'

class OEIS
  def self.a271410(n)
    Subset.one_indexed(n).reduce(1, :lcm)
  end
end
