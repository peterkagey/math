require_relative 'helpers/nonpalindrome_counter'

class OEIS
  # Number of strings of length n over a 4 letter alphabet that do not begin
  # with a palindrome.
  def self.a252697(n)
    nonpalindrome_count(n, 4)
  end
end
