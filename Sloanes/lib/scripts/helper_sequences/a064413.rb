require_relative '../helpers/ekg_builder'
class OEIS

  A064413_SEQUENCE = EKGBuilder.sequence(500, [1, 2])

  def self.a064413(n)
    raise "A064413 not defined for n = #{n} < 1" if n < 1
    A064413_SEQUENCE[n - 1] ||
    EKGBuilder.sequence(n, [1, 2]).last
  end
end
