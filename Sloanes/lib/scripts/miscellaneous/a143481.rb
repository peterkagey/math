require_relative "../helpers/eulers_totient_function"
require_relative "a143480"
class OEIS

  def self.a143481(n)
    phi(a143480(n))
  end

end
