require_relative '../helpers/palindrome_counter'

class OEIS
  # Number of strings of length n over a 10 letter alphabet that do not begin
  # with a palindrome.
  def self.a252703(n)
    nonpalindrome_count(n, 10)
  end
end
