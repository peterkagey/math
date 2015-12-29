class A217489Builder

  def self.sequence(terms = 100)
    seq = [2]
    numbers = (3..5_000).select { |n| !(n.to_s =~ /1/) }

    while seq.length < terms
      next_term = numbers.find { |n| condition(n, seq.last) }
      numbers -= [next_term]
      seq << next_term
    end
    seq
  end

  def self.condition(n, m)
    all_digits = m.to_s.each_char.map(&:to_i)
    (all_digits - [0]).find { |i| n % i == 0 }.nil?
  end

end

class OEIS

  A217489_SEQUENCE = A217489Builder.sequence

  def self.a217489(n)
    raise "not defined for n = #{n} < 1" if n < 1
    A217489_SEQUENCE[n - 1]
  end
end

