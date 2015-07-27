require_relative 'a260510'

class OEIS
  # a(n) counts the number of sequences n = b_1 < b_2 < ... < b_t = A006255(n)
  # such that b_1*b_2*...*b_t is a perfect square.
  def self.a259527(n)
    2**a260510(n)
  end

end
