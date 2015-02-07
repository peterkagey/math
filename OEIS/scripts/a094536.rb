class OEIS

  def self.a094536(n)
    seq = [0,0]
    i = 2
    loop do
      return seq[n] if seq[n]
      a_i = 2 * seq[-1] 
      a_i += 2**(i/2) - seq[i/2] if i.even?
      seq << a_i
      i += 1
    end
  end

end

# (2..1000).each { |n| s << 2 * s[-1] + (n.odd? ? 0 : 2**(n/2) - s[n/2]) }

# s.each_with_index do |a,i|
#   puts a/(2**i).to_f
# end