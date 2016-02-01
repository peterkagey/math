require 'prime'

class OEIS
  # a(prime) = 1, a(mn) = m*a(n) + n*a(m)
  def self.a003415(n)
    return 0 if n <= 1
    return 1 if Prime.prime?(n)
    a = Prime.each.find { |i| n % i == 0 }
    b = n/a
    a * a003415(b) + b * a003415(a)
  end
end
