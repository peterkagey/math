# A249629: Number of strings of length n over a 4 letter alphabet that begin 
# with a nontrivial palindrome.
# a(0) = 0; a(1) = 0; a(n+1) = 4*a(n) + 4^ceil(n/2) - a(ceil(n/2))
require_relative  'palindrome_counter'

class OEIS
  def self.a249629(n)
    palindrome_count(n, 4)
  end
end