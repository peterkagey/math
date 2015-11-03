require_relative '../helpers/palindromes'

class OEIS

  A060947_SEQUENCE = IntrinsicKPalindromes.new(10, 10000).all

  def self.a060947(n)
    raise "A060947 is not defined for n = #{n} < 1" if n < 1
    A060947_SEQUENCE[n - 1]
  end

end
