require_relative '../../tools/helpers/local_b_file'

class A265415Builder
  A260643 = LocalBFile.new(260643).to_ary
  def self.sequence
    A260643.each_index.select { |i| A260643[i] == 1 }.map(&:next)
  end
end

class OEIS
  A265415_SEQUENCE = A265415Builder.sequence

  def self.a265415(n)
    max_term = A265415_SEQUENCE.length
    raise "A265415 is not defined for n = #{n}" unless (1..max_term).include?(n)
    A265415_SEQUENCE[n - 1]
  end
end
