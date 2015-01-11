# A249641: Number of strings of length n over an 8 letter alphabet that begin 
# with a nontrivial palindrome.
# a(0) = 0; a(1) = 0; a(n+1) = 6*a(n) + 6^ceil(n/2) - a(ceil(n/2))

seq = [0, 0]
n = 30
(2..n).each do |i|
	seq << 8 * seq[i-1] + 8**((i+1)/2) - seq[(i+1)/2]
end
