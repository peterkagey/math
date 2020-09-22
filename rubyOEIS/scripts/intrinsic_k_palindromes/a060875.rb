require_relative '../helpers/palindromes'

class OEIS

  A060875_SEQUENCE = IntrinsicKPalindromes.new(5, 1000).all

  def self.a060875(n)
    raise "A060875 is not defined for n = #{n} < 1" if n < 1
    A060875_SEQUENCE[n - 1]
  end

end
