require_relative 'a048798'

class OEIS
  # k > ((n/a048798(n))^(1/3)).ceil
  def self.a254767(n)
    # a(n) is the least k > n such that k*n is a perfect cube.
    ratio = n/a048798(n).to_f
    k = int_cube_root(ratio) + 1
    k**3 * a048798(n)
    # min = (n**(2/3.0)).ceil
    # (min..n+1).each { |i| return i**3/n if i**3 % n == 0 && i**3 > n**2 }

  end

  def self.int_cube_root(n)
    (n**(1/3.0)).to_i
  end
  private_class_method :int_cube_root

end
