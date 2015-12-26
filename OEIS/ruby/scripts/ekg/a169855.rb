require_relative '../helpers/ekg_builder'
class OEIS
  A169855_SEQUENCE = EKGBuilder.sequence(10_000, [12])
  def self.a169855(n)
    A169855_SEQUENCE[n - 1] || EKGBuilder.sequence(n, [12]).last
  end
end
