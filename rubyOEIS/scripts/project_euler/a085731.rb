require_relative '../helper_sequences/a003415'

class OEIS

  def self.a085731(n)
    a003415(n).gcd(n)
  end

end
