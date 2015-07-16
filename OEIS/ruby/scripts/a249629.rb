require_relative 'helpers/palindrome_counter'

class OEIS
  # Number of strings of length n over a 4 letter alphabet that begin with a
  # nontrivial palindrome.
  def self.a249629(n)
    palindrome_count(n, 4)
  end
end
