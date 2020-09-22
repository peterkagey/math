require_relative "../helper_sequences/a003056"
require_relative "../helper_sequences/a000217"

class OEISTable

  def self.n_k(i)
    a003056 = OEIS.a003056(i)
    a002262 = i - OEIS.a000217(a003056)
    a025581 = a003056 - a002262

    [a025581, a002262]
  end

end
