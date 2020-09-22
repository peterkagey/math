require_relative  '../helpers/palindrome_counter'

class OEIS
  # Number of strings of length n over a 5 letter alphabet that begin with a
  # nontrivial palindrome.
  def self.a249638(n)
    palindrome_count(n, 5)
  end
end
