require_relative '../helpers/subset_logic'

class OEIS
  @@a272011 = (0..10000).flat_map { |i| Subset.zero_indexed(i).reverse }

  def self.a272011(n)
    @@a272011[n]
  end
end
