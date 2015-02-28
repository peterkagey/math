# A248122: Number of strings of length n over a 3 letter alphabet that begin
# with a nontrivial palindrome.
# a(0) = 0; a(1) = 0; a(n+1) = 3*a(n) + 3^ceil(n/2) - a(ceil(n/2))

require_relative 'helpers/palindrome_counter'

class OEIS
  def self.a248122(n)
    palindrome_count(n, 3)
  end
end
