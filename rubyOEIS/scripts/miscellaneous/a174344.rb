require_relative "../helper_sequences/a000196"
require_relative "../helper_sequences/a001057"
require_relative "../helper_sequences/a002522"
require_relative "../helper_sequences/a002061"

class OEIS
  def self.a174344(n) # Ugly, but not recursive
    k = a000196(n - 1)
    return a001057(k) if (a002522(k)..a002061(k + 1)).include?(n)

    j = n - a002061(k + 1)
    k.odd? ? a001057(k) - j : a001057(k) + j
  end
end
