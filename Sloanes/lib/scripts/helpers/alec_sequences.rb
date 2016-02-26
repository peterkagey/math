class AlecSequences

  def self.generate(terms = 10, op = :+, given = [1], off = 1, &block)
    (given.length...terms).inject(given) do |seq|
      n = seq.length + off
      seq << (off...n).select { |i| yield(seq[i - off], n, i) }.reduce(op)
    end
  end

end
