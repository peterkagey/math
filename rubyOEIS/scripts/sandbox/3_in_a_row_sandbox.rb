class AlecTauCounter

  def initialize(game)
    @game = game
    @length = game.length - 1
  end

  def out_of_bounds?(*indices)
    indices.any? { |i| [0, @length].include?(i) }
  end

  def vertical(c_i, r_i)
    return 0 if out_of_bounds?(c_i)
    values = [
      @game[c_i - 1][r_i],
      @game[c_i][r_i],
      @game[c_i + 1][r_i],
    ]
    values.uniq.length == 1 ? 1 : 0
  end

  def horizontal(c_i, r_i)
    return 0 if out_of_bounds?(r_i)
    values = [
      @game[c_i][r_i - 1],
      @game[c_i][r_i],
      @game[c_i][r_i + 1],
    ]
    values.uniq.length == 1 ? 1 : 0
  end

  def diagonal_nw(c_i, r_i)
    return 0 if out_of_bounds?(r_i, c_i)
    values = [
      @game[c_i - 1][r_i - 1],
      @game[c_i][r_i],
      @game[c_i + 1][r_i + 1],
    ]
    values.uniq.length == 1 ? 1 : 0
  end

  def diagonal_ne(c_i, r_i)
    return 0 if out_of_bounds?(r_i, c_i)
    values = [
      @game[c_i + 1][r_i - 1],
      @game[c_i][r_i],
      @game[c_i - 1][r_i + 1],
    ]
    values.uniq.length == 1 ? 1 : 0
  end

  def count
    counter = 0
    (0..@length).each do |c_i|
      (0..@length).each do |r_i|
        counter += vertical(c_i, r_i)
        counter += horizontal(c_i, r_i)
        counter += diagonal_nw(c_i, r_i)
        counter += diagonal_ne(c_i, r_i)
      end
    end
    counter
  end

  def to_s
    @game.map { |ary| ary.join(" ")}.join("\n") +
    "\n Connections: #{count}\n "
  end
  alias :inspect :to_s

end

game = %(
a b c a a
a c a a a
a a a a a
a a a a a
a a a a a
)

n = 5
max = 0
min = n**3
y = (0...n**2).map { |i| 1 << i }.combination(n**2/2).map do |ary|
  x = ary.reduce(:^).to_s(2).rjust(n**2, '0').split("").each_slice(n).to_a
  y = AlecTauCounter.new(x)
  c = y.count
  if c > max
    puts "MAX: #{max = c} -- \n#{y}"
  elsif c < min
    puts "MIN: #{min = c} -- \n#{y}"
  end
  c
end

puts "\n**************************"
puts "MAX : #{y.max}"
puts "min : #{y.min}"
puts "**************************"


# x = AlecTauCounter.new(game)
# p x
