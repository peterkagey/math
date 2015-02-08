class OEIS
  def self.a254128(n)
    s = [0, 0]
    i = 2
    loop do
      return s[n] if s[n]
      k = i/2 + 1
      a_i = 2 * s[-1]
      a_i += 2**k - s[k] if i.odd?
      s << a_i
      i += 1
    end
  end
end
