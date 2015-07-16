require_relative 'helpers/palindrome_counter'

class OEIS
  # Number of strings of length n over a 3 letter alphabet that begin with a
  # nontrivial palindrome.
  def self.a248122(n)
    palindrome_count(n, 3)
  end
end
