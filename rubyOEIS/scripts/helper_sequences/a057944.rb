class OEIS

  # Largest triangular number less than or equal to n
  def self.a057944(n)
    k = (((1 + 8 * n)**0.5 - 1)/2).to_i
    k * (k + 1)/2
  end

end
