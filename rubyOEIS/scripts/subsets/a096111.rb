require_relative '../helpers/subset_logic'

class OEIS
  def self.a096111(n)
    Subset.one_indexed(n + 1).reduce(1, :*)
  end
end
