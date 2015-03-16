require_relative 'a072905'

class OEIS
  def self.a067722(n)
    # Least positive integer k such that n*(n + k) is a perfect square.
    return 1 if n == 0
    a072905(n) - n
  end
end
