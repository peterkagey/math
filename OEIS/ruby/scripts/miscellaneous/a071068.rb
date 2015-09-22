require_relative '../helpers/is_square'

class OEIS

  def self.a071068(n)
    (1..n/2).count { |i| i.is_squarefree? && (n - i).is_squarefree? }
  end

end
