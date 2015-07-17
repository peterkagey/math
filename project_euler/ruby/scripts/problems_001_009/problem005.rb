class ProjectEuler
  # 2520 is the smallest number that can be divided by each of the numbers from
  # 1 to 10 without any remainder.

  # What is the smallest positive number that is evenly divisible by all of the
  # numbers from 1 to 20?
  def self.problem005
    product = 1
    (1..20).each{ |n| product = product.lcm(n) }
    product
  end
  # 232792560
  # 1.4e-05 seconds
end
