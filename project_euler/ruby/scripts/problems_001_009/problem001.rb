require '/Users/pkagey/personal/math/project_euler/ruby/helpers/triangle.rb'
class ProjectEuler
  # If we list all the natural numbers below 10 that are multiples of 3 or 5,
  # we get 3, 5, 6 and 9. The sum of these multiples is 23.
  # Find the sum of all the multiples of 3 or 5 below 1000.

  def self.problem001
    3 * triangle(999/3) + 5 * triangle(999/5) - 15 * triangle(999/15)
  end
end

# 233168
# 6.0e-06 seconds
