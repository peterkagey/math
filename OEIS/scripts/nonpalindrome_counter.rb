# A252696: Number of strings of length n over a 3 letter alphabet that do not
# begin with a palindrome.

require_relative 'palindrome_counter'

def nonpalindrome_count(n, b)
  return 0 if n == 0
  b**n - palindrome_count(n,b)
end