class OEIS

  def self.a070939(n)
    n == 0 ? 1 : n.bit_length
  end

end
