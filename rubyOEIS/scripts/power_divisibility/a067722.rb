require_relative 'a072905'

class OEIS

  # Least positive integer k such that n*(n + k) is a perfect square.
  def self.a067722(n)
    return 1 if n == 0
    a072905(n) - n
  end
end
