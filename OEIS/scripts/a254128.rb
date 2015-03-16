class OEIS
  def self.a254128(n)
    # Number of binary strings of length n that begin with an odd-length
    # palindrome.
    s = [0, 0]
    i = 1
    while s[n].nil? && i += 1
      k = i/2 + 1
      s << 2 * s[-1] + (i.odd? ? 2**k - s[k] : 0)
    end
    s[n]
  end
end
