class OEIS

  def self.a216256(n)
    (Math.sqrt(3*n - 0.75) - 0.5).ceil
  end

end
