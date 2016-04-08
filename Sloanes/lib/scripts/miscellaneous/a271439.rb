require_relative '../helper_sequences/a002024'

class OEIS
  def self.a271439(n)
    a002024(n) != a002024(n + 1) ? 0 : n - a002024(n) + 1
  end
end
