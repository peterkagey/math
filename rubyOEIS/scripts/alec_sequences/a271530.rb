require_relative '../helpers/alec_sequences'

class A271530Builder
  def self.sequence(terms, seed)
    AlecSequences.generate(terms, :*, e = 1, seed) do |a_i, n, i|
      a_i % i == n % i
    end
  end
end

class OEIS
  @@a271530 = A271530Builder.sequence(1, [1])

  def self.a271530(n)
    raise "A271530 is not defined for n = #{n} < 1" if n < 1
    @@a271530 = A271530Builder.sequence(n, @@a271530)
    @@a271530[n - 1]
  end
end

# a(1) = 0 by definition.
# a(2) = 1, because 2 == a(1) (mod 1);
# a(3) = 2, because 3 == a(1) (mod 1), and 3 == a(2) (mod 2): 1 * 2 = 2;
# a(4) = 1, because 4 == a(1) (mod 1);
# a(5) = 24, because 5 == k (mod k) for 1 < k < 5: 1 * 2 * 3 * 4 = 24.
