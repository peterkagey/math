require_relative '../helpers/stopper'

class OEIS
  def self.a056792(n)
    stopper(1, 2, n)
  end
end
