class OEIS

  class A268642
    def self.sequence(terms = 100)
      seq = [1]
      ordered_terms = SortedSet.new(seq)
      (terms - 1).times do
        a, b = (seq.last/2.0).ceil, seq.last * 3
        (seq << a; ordered_terms << a; next) if !ordered_terms.include?(a)
        (seq << b; ordered_terms << b; next) if !ordered_terms.include?(b)
        break
      end
      seq
    end
  end

  A268642_SEQUENCE = A268642.sequence

  def self.a268642(n)
    raise "A268642 not defined for n = #{n} < 1" if n < 1
    A268642_SEQUENCE[n - 1] || A268642.sequence(n).last
  end
end
