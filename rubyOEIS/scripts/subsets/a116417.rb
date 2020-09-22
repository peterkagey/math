require_relative '../helpers/subset_logic'

class OEIS
  def self.a116417(n)
    inverse_sum = Subset.one_indexed(n).inject(0) do |accum, i|
      accum + Rational(1)/Rational(i)
    end

    inverse_sum.denominator
  end
end
