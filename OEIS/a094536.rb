s = [0,0]
(2..1000).each { |n| s << 2 * s[-1] + (n.odd? ? 0 : 2**(n/2) - s[n/2]) }

s.each_with_index do |a,i|
  puts a/(2**i).to_f
end

