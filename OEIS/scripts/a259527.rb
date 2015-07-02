require_relative 'a006255'
require_relative 'helpers/subset_logic'
require_relative 'helpers/perfect_square_product'

class OEIS

  def self.a259527(n)
    helper = OEISHelper::A259527.new(n)
    helper.parity_factor * helper.subset_count
  end

end

module OEISHelper
  class A259527

    def initialize(n); @n = n end
    def g(n); @g_n ||= OEIS.a006255(n) end
    def parity_factor; 1 << square_terms.count end
    def subset_count; useful_terms.count_subsets { |s| valid_subset?(s) } end

    private
    attr_reader :n

    def all_terms; (n+1..g(n)).to_a end
    def square_terms; all_terms.select { |i| [i].perfect_square? } end
    def valid_subset?(subset); ([n, g(n)] + subset).perfect_square? end

    # Because g(n) <= 2n for all n > 3, prime values will never contribute to a
    # valid sequence, thus they can be thrown out. Also, the multiplicies from
    # perfect square terms are counted elsewhere.
    def useful_terms
      candidates = all_terms - square_terms
      candidates.select! { |i| !Prime.prime?(i) } if n > 3
      candidates
    end

  end
end
