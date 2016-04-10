class OEIS

  # n appears n times; floor(sqrt(2n) + 1/2).
  @@a002024 = []
  def self.a002024(n)
    @@a002024[n] ||= ((2*n)**0.5 + 0.5).to_i
  end

end
