require_relative '../helpers/ekg_builder'
class OEIS
  A169849_SEQUENCE = EKGBuilder.sequence(100, [9])
  def self.a169849(n)
    A169849_SEQUENCE[n - 1] || EKGBuilder.sequence(n, [9]).last
  end
end
