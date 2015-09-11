require_relative "../helpers/eulers_totient_function"
require_relative "a143482"
class OEIS

  def self.a143483(n)
    phi(a143482(n))
  end

end
