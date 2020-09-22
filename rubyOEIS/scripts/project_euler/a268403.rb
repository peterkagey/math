require_relative 'a080715'
require_relative '../helpers/sums_and_differences'
require_relative '../../tools/helpers/local_b_file'

class OEIS
  A268403_SEQUENCE = A080715Builder.sequence.cumulative_sum
  def self.a268403(n)
    raise "A268403 is not defined for n = #{n} < 1" if n < 1
    A268403_SEQUENCE[n - 1] || A080715Builder.sequence(n).cumulative_sum[n - 1]
  end
end
