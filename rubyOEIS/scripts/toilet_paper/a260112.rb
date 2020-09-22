require_relative '../helpers/toilet_paper'

class OEIS
  def self.a260112(n)
    toilet_paper(1, 4, n)
  end
end
