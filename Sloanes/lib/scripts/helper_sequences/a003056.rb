require_relative 'a002024'
class OEIS

  # n appears n times; floor(sqrt(2n) + 1/2).
  def self.a003056(n)
    a002024(n + 1) - 1
  end

end
