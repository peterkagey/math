class Paths
  attr_reader :number_of_iterations, :exponent_sequences

  def initialize(number_of_iterations, exponent_sequences)
    @number_of_iterations = number_of_iterations
    @exponent_sequences = exponent_sequences
  end

  def make(j)
    Paths.new(
      @number_of_iterations + 1,
      @exponent_sequences.map { |s| s + [j] }
    )
  end

  def append(paths, j)
    if paths.number_of_iterations < @number_of_iterations
      Paths.new(
        @number_of_iterations,
        @exponent_sequences + paths.exponent_sequences.map { |s| s + [j] }
      )
    else
      self
    end
  end

  def to_s
    "(#{@number_of_iterations}, #{@exponent_sequences.length}): #{@exponent_sequences}"
  end
end

# n = 10000
# a307092 = Array.new(n)
# a307092[1] = Paths.new(0, [[]])
# a307092[2] = Paths.new(1, [[0]])
#
# (1..Float::INFINITY).each do |a|
#   indices = a307092.each_index.select { |j| a307092[j] && a307092[j].number_of_iterations == a }
#   indices.each do |k|
#     (0..Float::INFINITY).each do |i|
#       break if k + k**i > n
#       if a307092[k + k**i].nil?
#         a307092[k + k**i] = a307092[k].make(i)
#       else
#         a307092[k + k**i] = a307092[k + k**i].append(a307092[k], i)
#       end
#     end
#   end
#   break if a307092.count(&:nil?) == 1
# end
#
# a307092[2..-1].each_with_index { |e, i| puts "#{i + 2} #{e.exponent_sequences.length}"}


def predecessors(n)
  return [] if n < 2
  return [1] if n == 2
  candidates = (0..Math.log(n, 2)).map do |j|
    # x -> x + x^j
    case j
    when 0 then n - 1
    when 1 then n.even? ? n/2 : nil
    else
      x = (n**Rational(1,j)).to_i
      x + x**j == n ? x : nil
    end
  end
  candidates.compact
end

# seq = [nil, nil, 1]
# (3..1000).each do |n|
#   # seq << predecessors(n).map { |i| seq[i] }.reduce(:+)
#   seq << predecessors(n).length
# end
# # p seq[2..-1].each_slice(2).map(&:first)
# p seq.each_index.select { |i| seq[i] == 3 }
