require_relative '../helpers/toilet_paper'

class OEIS
  def self.a061282(n)
    toilet_paper(1, 3, n)
  end
end
