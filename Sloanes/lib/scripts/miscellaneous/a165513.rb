require 'set'

class A165513Builder

  def self.sequence(terms = 10)
    A165513Builder.new(terms).compute_sequence
  end

  def initialize(terms)
    @terms = terms
    @min_n, @max_n = 1, compute_n(terms + 20)
    @min_k, @max_k = 2, compute_k(terms + 20)
    @limit = [a(@min_n, @max_k), a(@max_n, @min_k)].min
  end

  def compute_sequence
    x = SortedSet.new

    (@min_n..@max_n).each do |n|
      (@min_k..@max_k).each do |k|
        a_i = a(n, k)
        a_i > @limit ? next : x << a_i
      end
    end

    x.to_a[0, @terms]
  end

  def a(n, k)
    k * (k + 2*n + 1)/2
  end

  def compute_n(terms_count)
    (terms_count - 2)/2
  end

  def compute_k(terms_count)
    (0.5 * (Math.sqrt(8 * terms_count + 9) - 3)).ceil
  end

end

class OEIS

  A165513_SEQUENCE = A165513Builder.sequence

  def self.a165513(n)
    raise "A165513 is not defined for n = #{n} < 1" if n < 1
    A165513_SEQUENCE[n - 1] || A165513Builder.sequence(n).last
  end

end
