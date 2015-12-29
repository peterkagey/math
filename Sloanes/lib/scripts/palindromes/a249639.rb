require_relative '../helpers/palindrome_counter'

class OEIS
  # Number of strings of length n over a 6 letter alphabet that begin with a
  # nontrivial palindrome.
  def self.a249639(n)
    palindrome_count(n, 6)
  end
end
