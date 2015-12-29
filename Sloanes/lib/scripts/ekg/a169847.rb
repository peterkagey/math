require_relative '../helpers/ekg_builder'
class OEIS
  A169847_SEQUENCE = EKGBuilder.sequence(100, [8])
  def self.a169847(n)
    A169847_SEQUENCE[n - 1] || EKGBuilder.sequence(n, [8]).last
  end
end
