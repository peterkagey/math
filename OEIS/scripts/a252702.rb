require_relative 'helpers/nonpalindrome_counter'

class OEIS
  # Number of strings of length n over an 9 letter alphabet that do not begin
  # with a palindrome.
  def self.a252702(n)
    nonpalindrome_count(n, 9)
  end
end
