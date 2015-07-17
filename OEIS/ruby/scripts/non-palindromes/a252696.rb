require_relative '../helpers/nonpalindrome_counter'

class OEIS
  # Number of strings of length n over a 3 letter alphabet that do not begin
  # with a palindrome.
  def self.a252696(n)
    nonpalindrome_count(n, 3)
  end
end
