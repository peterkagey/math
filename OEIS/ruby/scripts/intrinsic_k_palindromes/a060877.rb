require_relative '../helpers/palindromes'

class OEIS

  A060877_SEQUENCE = IntrinsicKPalindromes.new(7, 10000).all

  def self.a060877(n)
    raise "A060877 is not defined for n = #{n} < 1" if n < 1
    A060877_SEQUENCE[n - 1]
  end

end
