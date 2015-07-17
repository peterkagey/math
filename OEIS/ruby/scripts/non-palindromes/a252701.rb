require_relative '../helpers/nonpalindrome_counter'

class OEIS
  # Number of strings of length n over an 8 letter alphabet that do not begin
  # with a palindrome.
  def self.a252701(n)
    nonpalindrome_count(n, 8)
  end
end
