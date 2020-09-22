class EKGBuilder
  require 'set'

  def self.sequence(terms, seed = [1, 2], proc = nil)
    return seed if seed.length >= terms
    seq = seed
    used_terms = SortedSet.new(seed)
    proc ||= ->(a, b){ a.gcd(b) != 1 }

    (terms - seed.length).times do
      last_term = seq.last
      a_i = (1..Float::INFINITY).find do |i|
        !used_terms.include?(i) && proc.yield(i, last_term)
      end

      used_terms << a_i # faster with SortedSet
      seq << a_i
    end

    seq
  end

end
