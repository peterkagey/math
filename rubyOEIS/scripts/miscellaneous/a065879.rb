require_relative 'a272759'

class OEIS
  def self.a065879(n)
    n * OEIS.a272759(n)
  end
end
