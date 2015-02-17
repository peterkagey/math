require_relative 'a072905'

class OEIS
  def self.a067722(n)
    a072905(n) - n
  end
end
