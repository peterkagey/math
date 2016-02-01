require_relative "../helper_sequences/a000217"
require_relative "../helper_sequences/a047838"

class OEIS
  def self.a128223(n)
    n.even? ? a000217(n) : a047838(n + 1)
  end
end

# This is the number of numbers required for
# 0 != 1
# 0 != 1 != 2 != 0
# 0 != 1 != 2 != 3 != 0 != 2 != 1 != 3
# 0 != 1 != 2 != 3 != 4 != 2 != 0 != 4 != 1 != 3 != 0
