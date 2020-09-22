require_relative '../helper_sequences/a000120'
require_relative 'a272756'

class OEIS
  def self.a065413(n)
    (1...OEIS.a272756(n)).count { |i| OEIS.a000120(n * i) == i }
  end
end
