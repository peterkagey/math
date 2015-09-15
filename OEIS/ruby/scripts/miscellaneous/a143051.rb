require_relative '../helpers/is_square'

class OEIS

  # Smallest number not occurring earlier and smaller than the largest square
  # so far, the next square if no such number exists.
  def self.a143051(n)
    return 0 if n == 0
    (n-1).is_square? ? (Math.sqrt(n-1) + 1)**2 : n - 1
  end

end
