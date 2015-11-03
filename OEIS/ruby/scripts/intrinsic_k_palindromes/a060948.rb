require_relative '../helpers/palindromes'

class OEIS

  A060948_SEQUENCE = IntrinsicKPalindromes.new(11, 10000).all

  def self.a060948(n)
    raise "A060948 is not defined for n = #{n} < 1" if n < 1
    A060948_SEQUENCE[n - 1]
  end

end
