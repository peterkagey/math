require_relative "../helper_sequences/a000217"
require_relative "../helper_sequences/a002024"
require_relative "../miscellaneous/a271439"

class OEIS
  def self.nw(n)
    k = a002024(n - 1)
    a000217(k) <= n ? 0 : n + 2 - 2 * k
  end

  def self.sw(n)
    n - 1 == a000217(a002024(n - 1)) ? 0 : n - 1
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
      v = ->(x){ a271439(x) }
      h = ->(x){ a271439(x - 1) }
      nw = ->(x){ nw(x) }
      sw = ->(x){ sw(x) }

      related_indices = (x_chain(i, v) + x_chain(i, h) + x_chain(i, nw) + x_chain(i, sw))
      related_terms = related_indices.map { |i| @@a269526[i - 1] }
      @@a269526 << (1..Float::INFINITY).find { |i| !related_terms.include?(i) }
    end
    @@a269526[n - 1]
  end

end
