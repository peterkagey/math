# A Pythagorean triplet is a set of three natural numbers, a < b < c, for
# which,

# a^2 + b^2 = c^2
# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

class ProjectEuler
  def self.problem009
    (334...500).each do |c|
      (0..c).each do |b|
        a = Math.sqrt(c**2 - b**2)
        next unless a == a.to_i
        return (a*b*c).to_i if a + b + c == 1000
      end
    end
  end
end
# 31875000
# 0.016549 seconds
