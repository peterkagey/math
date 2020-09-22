require_relative 'a174344'
require_relative 'a268038'

class OEIS
  def self.a180714(n)
    a174344(n + 1) - a268038(n + 1)
  end
end
