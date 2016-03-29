require_relative '../helper_sequences/a054519'
require_relative '../helper_sequences/a007955'

class OEIS

  def self.a999995(n)
    return n if n < 2
    k = (0..Float::INFINITY).find { |i| n <= a054519(i) }
    m = n - a054519(k)
    if m.even?
      (1..k).inject(1) { |a, i| a * a007955(i) } * k**(m/2)
    elsif k > Math.sqrt(k).floor * Math.sqrt(k).ceil
      a999995(n + 1) / k * Math.sqrt(k).ceil
    else
      a999995(n + 1) / Math.sqrt(k).floor
    end
  end

end
