class OEIS
  def self.a254734(n)
    (n+1..2*n).find { |k| k**4 % n == 0 }
  end
end

# (1..5000).each do |i|
#   puts "#{i} #{a(i)}"
# end

# str = ''
# (1..5000).each do |i|
#   str += "#{a(i)}, "
#   break if str.length > 255
# end
# p str