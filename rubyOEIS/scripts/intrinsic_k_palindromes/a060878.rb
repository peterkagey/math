require_relative '../helpers/palindromes'

class OEIS

  A060878_SEQUENCE = IntrinsicKPalindromes.new(8, 1000).all

  def self.a060878(n)
    raise "A060878 is not defined for n = #{n} < 1" if n < 1
    A060878_SEQUENCE[n - 1]
  end

end
