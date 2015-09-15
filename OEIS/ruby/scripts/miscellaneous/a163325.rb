class OEIS
  def self.a163325(n)
    base_3_ary = n.to_s(3).split('').reverse
    base_3_ary = base_3_ary.each_with_index.select { |x, i| i.even? }.map(&:first)
    base_3_ary.reverse.join.to_i(3)
  end
end
