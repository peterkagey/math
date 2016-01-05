require_relative '../helper_sequences/a003056'
require_relative '../helper_sequences/a000330'
require_relative '../helper_sequences/a057944'

class OEIS

  # 1 + 2+2 + 3+3+3 + 4+4+4+4 + ... + A002024(n)+...+A002024(n)
  # ────────────────────────┐         ────────────────────────┐
  #              A000330(k) ┘      (k + 1) * (n - A057944(n)) ┘
  #
  # where k = A002024(n + 1) - 1
  #
  # A060432(n) = A000330(A003056(n)) + (A003056(n) + 1) * (n - A057944(n))

  def self.a060432(n)
    k = a003056(n) # greatest index such that triangle(k) <= n.
    a000330(k) + (k + 1) * (n - a057944(n))
  end

end
