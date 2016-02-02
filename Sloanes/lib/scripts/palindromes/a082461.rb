require_relative '../helpers/palindromic_partitions'

class A082461Builder

  def self.sequence(terms = 100)
    ary = []
    c = 1010
    until ary.length == terms
      ary << c if is_smarandache?(c) && c.to_s != c.to_s.reverse
      c += 1
    end
    ary
  end

  def self.is_smarandache?(n)
    ary = n.to_s.split("")
    full_partitions = PalindromicPartitions.new.part(ary.length)
    all_partitions = full_partitions.map do |part|
      ary_copy = ary.dup
      part.map { |i| ary_copy.shift(i).join }
    end

    all_partitions.any? { |ary| ary == ary.reverse }
  end
end

class OEIS
  A082461_SEQUNECE = A082461Builder.sequence
  def self.a082461(n)
    raise "A082461 is not defined for n = #{n} < 1" if n < 1
    A082461_SEQUNECE[n - 1] || A082461Builder.sequence(n).last
  end
end
