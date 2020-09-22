class OEIS
  def self.a000120(n)
    (0...n.bit_length).count { |i| n[i] == 1 }
  end
end
