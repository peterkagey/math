require_relative 'helpers/palindrome_counter'

class OEIS
  # Number of strings of length n over an 8 letter alphabet that begin with a
  # nontrivial palindrome.
  def self.a249641(n)
    palindrome_count(n, 8)
  end
end
