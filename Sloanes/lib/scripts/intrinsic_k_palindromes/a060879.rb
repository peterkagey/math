require_relative '../helpers/palindromes'

class OEIS

  A060879_SEQUENCE = IntrinsicKPalindromes.new(9, 1000).all

  def self.a060879(n)
    raise "A060879 is not defined for n = #{n} < 1" if n < 1
    A060879_SEQUENCE[n - 1]
  end

end
