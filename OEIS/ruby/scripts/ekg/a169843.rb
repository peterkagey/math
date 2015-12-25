require_relative '../helpers/ekg_builder'
class OEIS
  A169843_SEQUENCE = EKGBuilder.sequence(10_000, [6])
  def self.a169843(n)
    A169843_SEQUENCE[n - 1] || EKGBuilder.sequence(n, [6]).last
  end
end
