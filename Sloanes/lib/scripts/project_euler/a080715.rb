require_relative '../helpers/is_square'
require_relative '../helpers/sieve_of_eratosthenes'

class A080715Builder

  PRIMES = sieve_of_eratosthenes(SquareLookup::MAX)

  def self.in_a080715?(n)
    return true if n == 1
    return false if n.odd? || n.is_nonsquarefree?
    return false unless PRIMES.include?(1 + n)
    return false unless PRIMES.include?(2 + n/2)

    (3..Math.sqrt(n)).all? { |d| n % d != 0 || PRIMES.include?(d + n/d) }
  end

  def self.sequence(terms = 200, starting_terms = [1])
    min = starting_terms.last + 1
    max = Float::INFINITY
    # Speed could be improved by sieve that leaves only numbers k such that
    # k + 1 is prime
    # k is squarefree
    # k % 4 == 2
    # instead of (min..max)
    (min...max).each do |n|
      break if starting_terms.length >= terms
      starting_terms << n if in_a080715?(n)
    end
    starting_terms
  end

end

class OEIS
  A080715_SEQUENCE = A080715Builder.sequence
  def self.a080715(n)
    raise "A080715 is not defined for n = #{n} < 1" if n < 1
    A080715_SEQUENCE[n - 1] ||
    A080715Builder.sequence(n, A080715_SEQUENCE)[n - 1]
  end
end
