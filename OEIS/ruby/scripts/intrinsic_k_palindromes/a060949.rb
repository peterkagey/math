require_relative '../helpers/palindromes'

class OEIS

  A060949_SEQUENCE = IntrinsicKPalindromes.new(12, 10000).all

  def self.a060949(n)
    raise "A060949 is not defined for n = #{n} < 1" if n < 1
    A060949_SEQUENCE[n - 1]
  end

end
