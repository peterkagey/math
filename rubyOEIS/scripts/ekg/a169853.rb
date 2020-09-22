require_relative '../helpers/ekg_builder'
class OEIS
  @@a169853 = [11]

  def self.a169853(n)
    @@a169853 = EKGBuilder.sequence(n, @@a169853)
    @@a169853[n - 1]
  end
end
