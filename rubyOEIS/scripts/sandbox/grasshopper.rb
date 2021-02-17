def a999999_list(n)
  x = Array.new(n,0)
  x[0] += 1
  position = 0

  (1..Float::INFINITY).each do |i|
    break if x.all? { |e| e > 0 }
    position = [(position - i) % n, (position + i) % n].min_by { |i| x[i]}
    x[position] += 1
  end
  x
end

# p f(ARGV[0].to_i)
# p (1..20).map { |i| a999999_list(i).reduce(:+) }
# biggest = 0
# (1..2000).each do |i|
#   m = a999999_list(i).max
#   if m > biggest
#     p [m, i]
#     biggest = m
#   end
# end
