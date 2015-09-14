class OEIS

  def self.a261865(n)
    (1..n**2 + 1).find do |k|
      sqrt_k = k**0.5
      c = (n/sqrt_k + 1).to_i
      c * sqrt_k < n + 1
    end
  end

end
