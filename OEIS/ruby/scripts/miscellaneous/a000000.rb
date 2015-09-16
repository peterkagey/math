class A000000Builder
  # A212292

  # number of ways to represent
  # 2 * n - 1 as p^2 + q^2 + r
  # with p, q, r prime and p >= q


  require 'prime'

  def self.sequence(target_length = 1000)
    a000000 = Array.new(target_length) {0}

    primes = Prime.each(2 * target_length).to_a

    each_pair_of_primes((2*target_length)**0.5) do |p_0, q_0|
      primes.each do |r_0|
        a_i = p_0**2 + q_0**2 + r_0
        break if a_i > 2 * target_length
        a000000[(a_i - 1)/2] += 1 if a_i.odd?
      end
    end

    a000000
  end

  def self.each_pair_of_primes(max)
    primes = Prime.each(max.to_i).to_a
    primes.each do |p_0|
      primes.each { |q_0| q_0 > p_0 ? break : yield(p_0, q_0) }
    end
  end

end

class OEIS

  A000000_SEQUENCE = A000000Builder.sequence(10000)

  def self.a000000(n)
    raise "A000000 is not defined for n = #{n}" if n < 1
    A000000_SEQUENCE[n-1]
  end
end
