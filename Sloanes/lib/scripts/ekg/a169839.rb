require_relative '../helpers/ekg_builder'
class OEIS
  A169839_SEQUENCE = EKGBuilder.sequence(100, [4])
  def self.a169839(n)
    A169839_SEQUENCE[n - 1] || EKGBuilder.sequence(n, [4]).last
  end
end
