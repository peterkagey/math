class AlecSequences

  def self.generate(terms = 10, op = :+, given = [1], off = 1, e = 0, &block)
    (given.length...terms).inject(given) do |seq|
      n = seq.length + off
      matching_terms = [e] + (off...n).select { |i| yield(seq[i - off], n, i) }
      seq << matching_terms.reduce(op)
    end
  end

  def self.count(terms = 10, given = [1], off = 1, &block)
    (given.length...terms).inject(given) do |seq|
      n = seq.length + off
      seq << seq.count { |i| yield(i, n) }
    end
  end

end
