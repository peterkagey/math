class OEIS

  def self.a117484(n)
    (0...n).map { |i| (i * i + i)/2 % n}.uniq.length
  end

end
