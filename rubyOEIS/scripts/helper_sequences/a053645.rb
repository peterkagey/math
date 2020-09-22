require_relative 'a000523'

class OEIS
  def self.a053645(n)
    n & ((1 << a000523(n)) - 1)
  end
end
