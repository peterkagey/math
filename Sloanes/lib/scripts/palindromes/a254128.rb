class OEIS
  # Number of binary strings of length n that begin with an odd-length
  # palindrome.
  def self.a254128(n)
    (2..Float::INFINITY).inject([0, 0]) do |s, i|
      return s[n] if s[n]
      k = i/2 + 1
      s << 2 * s[-1] + (i.odd? ? 2**k - s[k] : 0)
    end
  end
end
