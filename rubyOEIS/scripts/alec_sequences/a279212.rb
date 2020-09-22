class A279212Builder
  def self.table(terms, seed)
    AlecSequences.generate(terms, :max, e = 0, seed) { |a_i, n| n % a_i == 0 }
  end
end

class OEIS
  @@a279212_table = []

  def self.a279212_t(n,k)
    return 0 if n < 0
    return 0 if k < 0
    return 1 if n == 1 && k == 1
    @@a279212_table[n] ||= []
    @@a279212_table[n][k] ||=
    # row
    (1...k).map { |i| a279212_t(n,i) }.reduce(0,:+) +
    # column
    (1...n).map { |i| a279212_t(i,k) }.reduce(0,:+) +
     # diagonal
    (1...[n,k].min).map { |i| a279212_t(n-i,k-i) }.reduce(0,:+) +
    # antidiagonal
    (1...k).map { |i| a279212_t(n+i,k-i) }.reduce(0,:+)
  end
end

puts OEIS.a279212_t(ARGV[0].to_i, ARGV[1].to_i)
