  class Integer
    def increment(x); self + 1 end
  end

  class AlecSequences

  def self.generate(terms, op, e = 1, given = [1], off = 1, &block)
    (given.length...terms).inject(given) do |seq|
      n = seq.length + off
      matching_terms = [e] + (off...n).select { |i| yield(seq[i - off], n, i) }
      seq << matching_terms.reduce(op)
    end
  end

end
