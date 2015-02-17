require_relative 'inverse_graham_hash'
class OEIS

  def self.A067565(n)
    InverseGraham::HASH[n]
  end

end