require_relative 'a272760'

class OEIS
  def self.a065880(n)
    return 0 if n == 0
    n * a272760(n)
  end
end
