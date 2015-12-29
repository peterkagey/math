require_relative '../helpers/palindrome_counter'

class OEIS
  # Number of strings of length n over a 7 letter alphabet that do not begin
  # with a palindrome.
  def self.a252700(n)
    nonpalindrome_count(n, 7)
  end
end
