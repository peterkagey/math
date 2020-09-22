require_relative '../helpers/ekg_builder'
class OEIS
  @@a169839 = [4]

  def self.a169839(n)
    @@a169839 = EKGBuilder.sequence(n, @@a169839)
    @@a169839[n - 1]
  end
end
