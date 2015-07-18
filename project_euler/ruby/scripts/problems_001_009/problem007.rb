require_relative '../../helpers/first_n_primes'

class ProjectEuler

  # By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
  # that the 6th prime is 13.
  # What is the 10 001st prime number?
  def self.problem007
    first_n_primes(10001).last
  end
  # 0.024731 seconds
end
