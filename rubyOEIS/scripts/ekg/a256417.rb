require 'prime'
require_relative 'a064413'

class OEIS
  def self.a256417(n)
    ekg = a064413(n)
    return 2 * ekg if Prime.prime?(ekg)
    return 2 * ekg/3 if ekg % 3 == 0 && Prime.prime?(ekg/3)
    ekg
  end
end
