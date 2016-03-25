class OEIS

  @@a032741 = []

  def self.a032741(n)
    return @@a032741[n] if @@a032741[n]
    sqrt = Math.sqrt(n)
    d = (1...sqrt).count { |i| n % i == 0 }
    @@a032741[n] = sqrt.round**2 == n ? 2 * d : 2 * d - 1
  end

end
