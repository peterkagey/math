require_relative 'a067565'

class OEIS
  SEQUENCE = (1..5000).map { |i| OEIS.a067565(i) }.reject { |a_i| a_i == 0 }
  def self.composite_inverse_graham(n)
    SEQUENCE[n-1]
  end
end
