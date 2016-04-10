require_relative '../helpers/ekg_builder'
class OEIS
  @@a169847 = [8]

  def self.a169847(n)
    @@a169847 = EKGBuilder.sequence(n, @@a169847)
    @@a169847[n - 1]
  end
end
