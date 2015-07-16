require_relative 'helpers/nonpalindrome_counter'

class OEIS
  # Number of strings of length n over a 6 letter alphabet that do not begin
  # with a palindrome.
  def self.a252699(n)
    nonpalindrome_count(n, 6)
  end
end
