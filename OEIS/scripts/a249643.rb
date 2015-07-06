require_relative 'helpers/palindrome_counter'

class OEIS
  # Number of strings of length n over a 10 letter alphabet that begin with a
  # nontrivial palindrome.
  def self.a249643(n)
    palindrome_count(n, 10)
  end
end
