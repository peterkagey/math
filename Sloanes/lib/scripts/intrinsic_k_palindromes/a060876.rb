require_relative '../helpers/palindromes'

class OEIS

  A060876_SEQUENCE = IntrinsicKPalindromes.new(6, 1000).all

  def self.a060876(n)
    raise "A060876 is not defined for n = #{n} < 1" if n < 1
    A060876_SEQUENCE[n - 1]
  end

end
