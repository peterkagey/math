require_relative '../helpers/toilet_paper'

class OEIS
  def self.a056792(n)
    toilet_paper(1, 2, n)
  end
end
