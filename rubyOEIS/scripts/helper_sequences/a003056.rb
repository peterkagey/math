require_relative 'a002024'
class OEIS

  def self.a003056(n)
    a002024(n + 1) - 1
  end

end
