require_relative '../helpers/ekg_builder'
class OEIS
  @@a064413 = [1, 2]

  def self.a064413(n)
    @@a064413 = EKGBuilder.sequence(n, @@a064413)
    @@a064413[n - 1]
  end
end
