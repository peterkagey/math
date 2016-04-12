  class Integer
    def increment(x); self + 1 end
    def binary(k); self + (1 << k) end
    def max(k); [self, k].max end
  end

  class AlecSequences

  def self.generate(terms, op, e = 1, given = [1], off = 1, &block)
    (given.length...terms).inject(given) do |seq|
      n = seq.length + off
      matching_terms = (off...n).select { |i| yield(seq[i - off], n, i) }
      seq << matching_terms.reduce(e, op)
    end
  end

end
