require 'nonpalindrome_counter'

class OEIS
  def self.a252703(n)
    # A252703: Number of strings of length n over a 10 letter alphabet that do not 
    # begin with a palindrome.
    nonpalindrome_counter(n, 10)
  end
end

# b = 10
# old_seq = "A249643"

# def f(k, n)
# 	seq = [1, 0]
# 	(2..n).each { |i| seq << k * seq[i-1] + k**((i+1)/2) - seq[(i+1)/2] }
# 	seq.each_with_index.collect { |a, i| k**i - a }
# end

# ##############################################################################

# seq = f(b, 1000)
# str = '0'; index = 1

# until "#{str}, #{seq[index]}".length > 260 do
# 	str << ", #{seq[index]}"
# 	index += 1
# end

# print "\n"
# print "#{str}\n\n"
# print "\n"
# print "#{seq[200]/b**200.to_f} = #{m = seq[300]/b**300.to_f} ?\n\n"

# print "#{b} divides a(n) for all n.
# lim n -> infinity a(n)/#{b}^n ~ #{m} is the probability that a random, infinite string over a #{b} letter alphabet does not begin with a palindrome.
# This sequence counts the number of walks on K_#{b} with loops that do not begin with a palindromic sequence.\n\n"

# print "a(n) = #{b}^n - #{old_seq}(n) for n > 0\n\n"

# def first_twenty(b)
# 	list = []
# 	(0...b**3).each do |m|
# 		n = m.to_s(b).rjust(3, "0")
# 		list << n if n[0..-1] != n[0..-1].reverse && n[0...-1] != n[0...-1].reverse
# 		break if list.length == 20
# 	end
# 	list
# end

# print "For n = #{b}, the first 20 of the a(#{3}) = #{seq[3]} solutions are (in lexicographic order): #{first_twenty(b).join(", ")}\n\n"

# print "(Ruby) seq = [1, 0];" +
# 	" (2..N).each { |i| seq << #{b} * seq[i-1] + #{b}**((i+1)/2) - seq[(i+1)/2] };" +
# 	" seq = seq.each_with_index.collect { |a, i| #{b}**i - a }\n\n"

# print "#{old_seq} gives the number of strings of length n over a #{b} letter alphabet that DO begin with a palindrome.
# Analogous sequences for k letter alphabets: A252696 (k=3), A252697 (k=4), A252698 (k=5), A252699 (k=6), A252700 (k=7), A252701 (k=8), A252702 (k=9), A252703 (k=10).\n\n"

# print "easy,nonn,walk\n\n"


# (0..1000).each do |i|
# 	print "#{i} #{seq[i]}\n"
# end
