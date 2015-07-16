require_relative 'helpers/palindrome_counter'

class OEIS
  # Number of strings of length n over a 9 letter alphabet that begin with a
  # nontrivial palindrome.
  def self.a249642(n)
    palindrome_count(n, 9)
  end
end
