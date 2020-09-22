require_relative '../helpers/ekg_builder'
class OEIS
  @@a169843 = [6]

  def self.a169843(n)
    @@a169843 = EKGBuilder.sequence(n, @@a169843)
    @@a169843[n - 1]
  end
end
