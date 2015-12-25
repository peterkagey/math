require_relative '../helpers/ekg_builder'
class OEIS
  A169841_SEQUENCE = EKGBuilder.sequence(10_000, [5])
  def self.a169841(n)
    A169841_SEQUENCE[n - 1] || EKGBuilder.sequence(n, [5]).last
  end
end
