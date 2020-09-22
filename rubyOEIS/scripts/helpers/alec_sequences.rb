class Integer
  def increment(x); self + 1 end

  # => Idea: These sequences, but instead of the sum of indices, the binary representation of the indices.
  # i.e. if 5, 4 and 1 match, then 0b11001
  # The sum_{i such that n % a_i == 0}(2 ^ i)
  def binary(k); self + (1 << k) end
  def max(k); [self, k].max end
end

class Rational
  def inverse_sum(k); (self + Rational(1)/k) end
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
