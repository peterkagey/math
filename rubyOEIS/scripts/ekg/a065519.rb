require_relative 'a064413'

class OEIS
  def self.a065519(n)
    a064413(n) - n
  end
end
