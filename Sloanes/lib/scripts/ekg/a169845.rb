require_relative '../helpers/ekg_builder'
class OEIS
  @@a169845 = [7]

  def self.a169845(n)
    @@a169845 = EKGBuilder.sequence(n, @@a169845)
    @@a169845[n - 1]
  end
end
