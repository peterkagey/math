require_relative 'a006255'
require_relative 'helpers/subset_logic'
require_relative 'helpers/perfect_square_product'

class OEIS

  def self.a259527(n)
    middle_terms(n).count_subsets { |s| full_set(n, s).perfect_square? }
  end

  def self.full_set(n, subset)
    [n] + subset + [a006255(n)]
  end
  private_class_method :full_set

  # Because g(n) <= 2n for all n > 3, prime values will never contribute to a
  # valid sequence, thus they can be thrown out.
  def self.middle_terms(n)
    all_terms = (n+1...a006255(n)).to_a
    n < 4 ? all_terms : all_terms.select { |i| !Prime.prime?(i) }
  end
  private_class_method :middle_terms

end
