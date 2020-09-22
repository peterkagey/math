class OEIS

  def self.a082647(k)
    max = (2 * k)**0.5
    (1..max.to_i).select { |d| d.odd? && k % d == 0 }.length
  end

end
