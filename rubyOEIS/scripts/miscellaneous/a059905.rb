class OEIS

  def self.a059905(n)
    (0..n.bit_length/2).to_a.map { |i| (n >> 2 * i & 1) << i}.reduce(:+)
  end

end
