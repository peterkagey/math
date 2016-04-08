require_relative '../helper_sequences/a000523'
require_relative '../helper_sequences/a053645'

class OEIS

  def self.a096111(n)
    k = n + 1
    max = k.bit_length
    (1..max).select { |i| k[i - 1] != 0 }.reduce(:*)
  end
end
