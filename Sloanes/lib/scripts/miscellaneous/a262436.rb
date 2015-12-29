require 'prime'

class A262436Builder

  # number of ways to represent 2 * n - 1 as p^2 + q^2 + r
  # with p, q, r prime and p >= q

  def self.sequence(target_length = 100)
    a262436 = Array.new(target_length) {0}

    primes = Prime.each(2 * target_length).to_a

    each_pair_of_primes((2*target_length)**0.5) do |p_0, q_0|
      primes.each do |r_0|
        a_i = p_0**2 + q_0**2 + r_0
        break if a_i > 2 * target_length
        a262436[(a_i - 1)/2] += 1 if a_i.odd?
      end
    end

    a262436
  end

  def self.each_pair_of_primes(max)
    primes = Prime.each(max.to_i).to_a
    primes.each do |p_0|
      primes.each { |q_0| q_0 > p_0 ? break : yield(p_0, q_0) }
    end
  end

end

class OEIS

  A262436_SEQUENCE = A262436Builder.sequence

  def self.a262436(n)
    raise "A262436 is not defined for n = #{n}" if n < 1
    A262436_SEQUENCE[n-1]
  end
end
