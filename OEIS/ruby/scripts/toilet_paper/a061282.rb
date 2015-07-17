require_relative '../helpers/stopper'

class OEIS
  def self.a061282(n)
    stopper(1, 3, n)
  end
end
