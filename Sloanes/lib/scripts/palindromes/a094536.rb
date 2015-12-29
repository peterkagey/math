class OEIS

  # Number of binary words of length n that are not "bifix-free".
  # Also the number of binary strings of length n that begin with an even length palindrome.
  def self.a094536(n)
    seq = [0,0]
    i = 2
    loop do
      return seq[n] if seq[n]
      a_i = 2 * seq[-1]
      a_i += 2**(i/2) - seq[i/2] if i.even?
      seq << a_i
      i += 1
    end
  end

end
