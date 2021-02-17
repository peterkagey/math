# This explores a question in Anany Levitin's article
# "One-move puzzles with mathematical content" that had already been answered
# in https://oeis.org/A002878

class FibonacciNumber
  attr_reader :a, :b, :n
  def initialize(n, a, b)
    @n = n
    @a = a
    @b = b
  end

  def self.from_index(n)
    return FibonacciNumber.new(1, 1, 0) if n == 1
    return FibonacciNumber.new(2, 0, 1) if n == 2
    penutimate = FibonacciNumber.from_index(n - 1)
    antepenutimate = FibonacciNumber.from_index(n - 2)
    FibonacciNumber.new(
      n,
      penutimate.a + antepenutimate.a,
      penutimate.b + antepenutimate.b
    )
  end

  def plus(other)
    throw "Cannot add" unless other.n == n + 1
    FibonacciNumber.new(n + 2, a + other.a, b + other.b)
  end

  def to_s
    "f(#{n}) = #{a}a + #{b}b"
  end

  def inspect
    to_s
  end
end

class FibonacciSum
  class FibonacciNumber
    attr_reader :a, :b, :n
    def initialize(n, a, b)
      @n = n
      @a = a
      @b = b
    end

    # def self.from_index(n)
    #   return FibonacciNumber.new(1, 1, 0) if n == 1
    #   return FibonacciNumber.new(2, 0, 1) if n == 2
    #   penutimate = FibonacciNumber.from_index(n - 1)
    #   antepenutimate = FibonacciNumber.from_index(n - 2)
    #   FibonacciNumber.new(
    #     n,
    #     penutimate.a + antepenutimate.a,
    #     penutimate.b + antepenutimate.b
    #   )
    # end
    #
    # def plus(other)
    #   throw "Cannot add" unless other.n == n + 1
    #   FibonacciNumber.new(n + 2, a + other.a, b + other.b)
    # end

    def to_s
      "s(#{n}) = #{a}a + #{b}b"
    end

    def inspect
      to_s
    end
  end
end

def fibonacci_numbers(n)
  seed = [FibonacciNumber.from_index(1), FibonacciNumber.from_index(2)]
  (3..n).reduce(seed) do |known_sequence, _|
    next_term = known_sequence.last(2).reduce { |a, b| a.plus(b) }
    known_sequence + [next_term]
  end
end

def partial_sums(fibonacci_sequence)
  fibonacci_sequence.drop(1).reduce([[1, 0]]) do |accum, f_n|
    a, b = accum.last
    accum + [[a + f_n.a, b + f_n.b]]
  end
end

def find_indices(fibonacci_sequence)
  partial_sums(fibonacci_sequence)
    .each_with_index
    .map { |partial, i|
      a, b = partial
      [[a, b, i + 1], divisible_by_fib(a, b, fibonacci_sequence)]
    }
    .to_h
    .select { |k, v| v.length > 0 }
    .map { |k, v| [k, v.map {|f_n| k.first / f_n.a}]}
    .flat_map(&:last)
end

def divisible_by_fib(a, b, fibonacci_sequence)
  return [] if a == 0 or b == 0
  fibonacci_sequence.select { |f_n| Rational(f_n.a, a) == Rational(f_n.b, b) }
end

fibs = fibonacci_numbers(50)
p find_indices(fibs)
