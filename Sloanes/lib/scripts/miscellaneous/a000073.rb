class OEIS
  # Tribonacci numbers: a(n) = a(n-1) + a(n-2) + a(n-3)
  # with a(0) = a(1) = 0 and a(2) = 1.
  def self.a000073(n)
    a = (19 + 3 * Math.sqrt(33))**(1/3.0)
    b = (19 - 3 * Math.sqrt(33))**(1/3.0)
    c = (586 + 102 * Math.sqrt(33))**(1/3.0)

    coefficient = 3 * c
    divisor = c**2 - 2 * c + 4
    base = (a + b + 1)/3.0

    (coefficient * base**(n-1) / divisor).round
  end

end
