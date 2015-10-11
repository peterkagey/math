class OEIS

  # a(n) = if n mod 2 = 0 then n*(n+1)/2 otherwise (n+1)^2/2-1.
  def self.a128223(n)
    return n * (n+1)/2 if n.even?
    (n+1)**2/2 - 1
  end
end

# This is the number of numbers required for
# 0 != 1
# 0 != 1 != 2 != 0
# 0 != 1 != 2 != 3 != 0 != 2 != 1 != 3
# 0 != 1 != 2 != 3 != 4 != 2 != 0 != 4 != 1 != 3 != 0
