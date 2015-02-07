class OEIS
  def self.a254733(n)
    (n+1..2*n).find { |k| k**3 % n == 0 }
  end
end

# str = ''
# (1..5000).each do |i|
#   str += "#{a(i)}, "
#   break if str.length > 255
# end
