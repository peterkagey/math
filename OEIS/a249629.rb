# A248122: Number of strings of length n over a 4 letter alphabet that begin 
# with a nontrivial palindrome.
# a(0) = 0; a(1) = 0; a(n+1) = 4*a(n) + 4^ceil(n/2) - a(ceil(n/2))

seq = [0, 0]
n = 30
(2..n).each do |i|
	seq << 4 * seq[i-1] + 4**((i+1)/2) - seq[(i+1)/2]
end