class OEIS

  def self.a227192(n)
    k = n.to_s(2).scan(/((\d)\2*)/)
    k.each_index.map { |i| (i + 1) * k[i][0].size }.reduce(:+)
  end

end
