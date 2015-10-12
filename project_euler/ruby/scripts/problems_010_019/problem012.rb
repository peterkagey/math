require_relative '../../helpers/triangle'
require_relative '../../helpers/sieve_of_eratosthenes'
require_relative '../../helpers/prime_factors'

class ProjectEuler

  def self.problem012
    i = 2
    primes = sieve_of_eratosthenes(10000)
    i += 1 until number_of_factors(triangle(i), primes) >= 500

    triangle(i)
  end

  def self.number_of_factors(n, primes)
    prime_factors_hash = prime_factors(n, primes)
    prime_factors_hash.values.map(&:next).reduce(:*)
  end

end
