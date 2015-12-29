require_relative 'a048798'

class OEIS
  # a(n) is the least k > n such that k*n is a perfect cube.
  def self.a254767(n)
    ratio = n/a048798(n).to_f
    k = (ratio**(1/3.0)).to_i + 1
    k**3 * a048798(n)
  end

end
