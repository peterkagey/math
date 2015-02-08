# A249638: Number of strings of length n over a 5 letter alphabet that begin
# with a nontrivial palindrome.
# a(0) = 0; a(1) = 0; a(n+1) = 5*a(n) + 5^ceil(n/2) - a(ceil(n/2))
require_relative  'palindrome_counter'

class OEIS
  def self.a249638(n)
    palindrome_count(n, 5)
  end
end
