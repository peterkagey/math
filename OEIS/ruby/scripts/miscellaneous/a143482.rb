require_relative "../helpers/eulers_totient_function"
class OEIS

  def self.a143482(n)
    return 1 if n == 1
    phi_last, k = phi(a143482(n-1)), 0
    return k if phi(k) >= phi_last while k += n
  end

end
