require_relative 'helpers/perfect_square_product'

class OEIS

  # Smallest number not occurring earlier and smaller than the largest square
  # so far, the next square if no such number exists.
  def self.a143051(n)
    return 0 if n == 0
    k = Math.sqrt(n-1)
    return n + 2 * k if k == k.round
    n-1
  end

end
