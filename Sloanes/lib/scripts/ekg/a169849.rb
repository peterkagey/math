require_relative '../helpers/ekg_builder'
class OEIS
  @@a169849 = [9]

  def self.a169849(n)
    @@a169849 = EKGBuilder.sequence(n, @@a169849)
    @@a169849[n - 1]
  end
end
