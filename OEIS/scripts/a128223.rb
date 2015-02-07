class OEIS
  def self.a128223(n)
    #a(n) = if n mod 2 = 0 then n*(n+1)/2 otherwise (n+1)^2/2-1.
    return n * (n+1)/2 if n.even?
    (n+1)**2/2 - 1
  end
end