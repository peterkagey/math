require_relative "../helper_sequences/a000196"
require_relative "../helper_sequences/a001057"
require_relative "../helper_sequences/a002061"
require_relative "../helper_sequences/a002522"
require_relative "../helper_sequences/a003059"

class OEIS

  def self.a268038(n)
    k = n == 1 ? 0 : a003059(n - 1)
    return -a001057(k - 1) if (a002061(k)..a002522(k)).include?(n)
    j, h = n - a002522(k - 1), a001057(k - 2)
    k.odd? ? j - h : -(j + h)
  end

end
