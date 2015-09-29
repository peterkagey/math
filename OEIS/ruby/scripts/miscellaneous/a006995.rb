class A006995Builder

  def self.odd_palindrome(j); (j + j.reverse[1..-1]).to_i(2) end
  def self.even_palindrome(j); (j + j.reverse).to_i(2) end

  def self.each_n_bit_number(i)
    (2**(i-1)...2**i).each { |j| yield j.to_s(2) }
  end

  def self.sequence(target_length = 10_000)
    a006995 = [0]
    number_of_digits = (Math.log(target_length + 1)/Math.log(2) - 1).ceil
    (1..number_of_digits).each do |i|
      each_n_bit_number(i) { |j| a006995 << odd_palindrome(j) }
      each_n_bit_number(i) { |j| a006995 << even_palindrome(j) }
    end
    a006995
  end

end

class OEIS

  A006995_SEQUENCE = A006995Builder.sequence

  def self.a006995(n)
    raise "A006995 not defined for n = #{n} < 1." if n < 1
    A006995_SEQUENCE[n-1] || A006995Builder.sequence(n)[n-1]
  end

end
