require_relative '../helpers/ekg_builder'
class OEIS
  @@a169851 = [10]

  def self.a169851(n)
    @@a169851 = EKGBuilder.sequence(n, @@a169851)
    @@a169851[n - 1]
  end
end
