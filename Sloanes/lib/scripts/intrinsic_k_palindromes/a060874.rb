require_relative '../helpers/palindromes'

class OEIS

  A060874_SEQUENCE = IntrinsicKPalindromes.new(4, 1000).all

  def self.a060874(n)
    raise "A060874 is not defined for n = #{n} < 1" if n < 1
    A060874_SEQUENCE[n - 1]
  end

end
