require_relative '../helpers/ekg_builder'
class OEIS
  A169853_SEQUENCE = EKGBuilder.sequence(100, [11])
  def self.a169853(n)
    A169853_SEQUENCE[n - 1] || EKGBuilder.sequence(n, [11]).last
  end
end
