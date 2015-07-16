require_relative 'helpers/palindrome_counter'

class OEIS
  # Number of strings of length n over a 7 letter alphabet that begin with a
  # nontrivial palindrome.
  def self.a249640(n)
    palindrome_count(n, 7)
  end
end
