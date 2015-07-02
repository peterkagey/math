require_relative '../a248663'

class Array
  # Let S = {n = a_0, a_1, a_2, ..., a_t = g(n)}.
  # The product of S is a perfect square if and only if
  # h(a_0) ^ h(a_1) ^ ... ^ h(a_t) == 0
  def perfect_square?
    self.map{ |i| OEIS.a248663(i) }.reduce(:^) == 0
  end

end
