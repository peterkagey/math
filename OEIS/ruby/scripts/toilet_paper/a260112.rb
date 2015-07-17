require_relative '../helpers/stopper'

class OEIS
  def self.a260112(n)
    stopper(1, 4, n)
  end
end
