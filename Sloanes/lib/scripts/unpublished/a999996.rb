require_relative '../alec_sequences/a269347'

class OEIS
  def self.a999996(n)
    OEIS.a269347(3 * n)/3 - (n**2 + 1)
  end
end
