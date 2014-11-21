def sieve_of_eratosthenes(n)
	return [] if n < 2
	p = 2
	bool_arry = [false] + [false] + [true] * (n-1)
	loop do
		(2*p..n).step(p).each { |i| bool_arry[i] = false }
		loop do 
			p += 1
			break if bool_arry[p] || p >= n
		end
		break if p >= n
	end
	bool_arry.each_index.select{ |i| bool_arry[i] }
end