# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# Find the sum of all of the primes below two million.

require 'prime'

class ProjectEuler
  def self.problem010
    Prime.each(2_000_000).reduce(:+)
  end
end

# 142913828922
# 0.471795 seconds
