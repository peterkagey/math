def palindrome_count(n, b)
  seq = [0, 0]
  i = 0
  while seq[n].nil? && i += 1
    k = 1 + i/2
    seq << b * seq[i] + b**k - seq[k]
  end
  seq[n]
end

def nonpalindrome_count(n, b)
  return 0 if n == 0
  b**n - palindrome_count(n,b)
end
