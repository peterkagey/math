require_relative '../helpers/subset_logic'

class OEIS
  @@a272020 = (0..10000).flat_map { |i| Subset.one_indexed(i).reverse }

  def self.a272020(n)
    @@a272020[n]
  end
end
