require_relative 'inverse_graham_hash'
class OEIS

  def self.inverse_graham(n)
    InverseGraham::HASH[n]
  end

end