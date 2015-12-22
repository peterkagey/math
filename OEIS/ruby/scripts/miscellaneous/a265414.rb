require_relative '../helpers/b_file'

class A265414Builder
  A260643 = BFile.new(260643).to_ary
  def self.sequence
    (1..A260643.max).map { |i| A260643.index(i) + 1 }
  end
end

class OEIS
  A265414_SEQUENCE = A265414Builder.sequence

  def self.a265414(n)
    max_term = A265414_SEQUENCE.length
    raise "A265414 is not defined for n = #{n}" unless (1..max_term).include?(n)
    A265414_SEQUENCE[n - 1]
  end
end
