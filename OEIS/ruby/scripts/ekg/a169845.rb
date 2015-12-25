require_relative '../helpers/ekg_builder'
class OEIS
  A169845_SEQUENCE = EKGBuilder.sequence(10_000, [7])
  def self.a169845(n)
    A169845_SEQUENCE[n - 1] || EKGBuilder.sequence(n, [7]).last
  end
end
