require_relative '../helpers/ekg_builder'
class OEIS
  @@a169841 = [5]

  def self.a169841(n)
    @@a169841 = EKGBuilder.sequence(n, @@a169841)
    @@a169841[n - 1]
  end
end
