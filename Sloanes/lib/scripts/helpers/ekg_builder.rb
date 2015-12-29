class EKGBuilder
  require 'set'

  def self.coprime(i, k)
    i.gcd(k) == 1
  end

  def self.sequence(terms, seed = [1, 2], proc = nil)
    seq = seed
    max_term = [terms * 2, 100].max
    remaining_terms = SortedSet.new(2..max_term) - seed
    proc = ->(a, b){ a.gcd(b) != 1 }

    (terms - seed.length).times do
      a_i = remaining_terms.find { |i| proc.yield(i, seq.last) }
      remaining_terms -= [a_i] # faster with SortedSet
      seq << a_i
    end

    seq
  end

end
