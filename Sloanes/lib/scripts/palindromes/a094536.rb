class OEIS

  # Number of binary words of length n that are not "bifix-free".
  # Also the number of binary strings of length n that begin with an even length palindrome.
  def self.a094536(n)
    (2..Float::INFINITY).inject([0, 0]) do |seq, i|
      return seq[n] if seq[n]
      delta = i.even? ? 2**(i/2) - seq[i/2] : 0
      seq << 2 * seq[-1] + delta
    end
  end

end
