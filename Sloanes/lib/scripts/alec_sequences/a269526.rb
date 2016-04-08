require_relative "../helper_sequences/a000217"
require_relative "../miscellaneous/a271439"

class OEIS
  def self.nw(n)
    min_k = (1..Float::INFINITY).find { |i| OEIS.a000217(i - 1) + 2 > n } - 1
    max_k = (min_k..Float::INFINITY).find { |i| OEIS.a000217(i) > n }
    return 0 if min_k != max_k
    n + 2 - 2 * min_k
  end

  def self.sw(n)
    k = (1..Float::INFINITY).find { |i| OEIS.a000217(i) >= n - 1 }
    n == OEIS.a000217(k) + 1 ? 0 : n - 1
  end

  def self.x_chain(n, f)
    chain = [f.yield(n)]
    return [] if chain == [0]
    while link = f.yield(chain.last)
      link == 0 ? break : chain << link
    end
    chain
  end

  @@a269526 = [1]

  def self.a269526(n)
    (@@a269526.length + 1..n).each do |i|
      v = ->(x){ OEIS.a271439(x) }
      h = ->(x){ OEIS.a271439(x - 1) }
      nw = ->(x){ OEIS.nw(x) }
      sw = -> (x){ OEIS.sw(x) }

      related_indices = (OEIS.x_chain(i, v) + OEIS.x_chain(i, h) + OEIS.x_chain(i, nw) + OEIS.x_chain(i, sw))
      related_terms = related_indices.map { |i| @@a269526[i - 1] }
      @@a269526 << (1..Float::INFINITY).find { |i| !related_terms.include?(i) }
    end
    @@a269526[n - 1]
  end

end
