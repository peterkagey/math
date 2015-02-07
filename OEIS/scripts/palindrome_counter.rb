def palindrome_count(n, b)

  seq = [0, 0]
  i = 2
  loop do
    return seq[n] if seq[n]
    k = (i+1)/2
    a_i = b * seq[i-1] + b**k - seq[k]
    seq << a_i
  end

end