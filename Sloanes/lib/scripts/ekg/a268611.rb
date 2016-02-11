require_relative '../helper_sequences/a256417'

class OEIS
  def self.a268611(n)
    a256417(n) - n
  end
end

