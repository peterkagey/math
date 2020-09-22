def palindrome_count(n, b)
  sequence = (1...n).inject([0, 0]) do |seq, i|
    k = 1 + i/2
    seq << b * seq[i] + b**k - seq[k]
  end

  sequence.last
end

def nonpalindrome_count(n, b)
  return 0 if n == 0
  b**n - palindrome_count(n,b)
end
