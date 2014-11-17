start = Time.now
a123663 = [0]; k = 0; a_i = 0; n = 10000
loop do
	2.times do 
		k.times{ a_i += 2; a123663 << a_i }
		a_i += 1
		a123663 << a_i
	end
	k += 1
	break if a123663.length >= n
end
a123663 = a123663[0...n]
p Time.now-start