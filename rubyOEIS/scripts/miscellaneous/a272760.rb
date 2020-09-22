require_relative '../helper_sequences/a000120'
require_relative 'a272756'

class OEIS
  def self.a272760(n)
    (0...a272756(n)).reverse_each.find { |i| OEIS.a000120(n * i) == i } || 0
  end
end
