require_relative '../helpers/ekg_builder'
class OEIS
  @@a169855 = [12]

  def self.a169855(n)
    @@a169855 = EKGBuilder.sequence(n, @@a169855)
    @@a169855[n - 1]
  end
end
