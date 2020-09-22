require_relative 'a032741'

class OEIS
  def self.a054519(n)
    (0..n).inject(0) { |a, i| a + a032741(i) + 1 }
  end
end
