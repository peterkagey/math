require 'prime'

class ProjectEuler

  # The prime factors of 13195 are 5, 7, 13 and 29.
  # What is the largest prime factor of the number 600851475143 ?
  def self.problem003
    a = 600851475143
    Prime.each(6900) do |prime|
      a /= prime while a % prime == 0
      return prime if a == 1
    end
  end
  # 6857
  # 0.003549 seconds
end
