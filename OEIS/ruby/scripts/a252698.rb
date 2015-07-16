require_relative 'helpers/nonpalindrome_counter'

class OEIS
  # Number of strings of length n over a 5 letter alphabet that do not begin
  # with a palindrome.
  def self.a252698(n)
    nonpalindrome_count(n, 5)
  end
end
