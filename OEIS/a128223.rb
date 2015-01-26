def a(n)
  return n * (n+1)/2 if n.even?
  (n+1)**2/2 - 1 if n.odd?
end

(0..1000).each do |n|
	puts "#{n} #{a(n)}"
end