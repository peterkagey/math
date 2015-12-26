require_relative '../helpers/ekg_builder'
class OEIS
  A169851_SEQUENCE = EKGBuilder.sequence(10_000, [10])
  def self.a169851(n)
    A169851_SEQUENCE[n - 1] || EKGBuilder.sequence(n, [10]).last
  end
end
