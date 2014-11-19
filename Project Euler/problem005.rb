# 2520 is the smallest number that can be divided by each of the numbers from 
# 1 to 10 without any remainder.

# What is the smallest positive number that is evenly divisible by all of the 
# numbers from 1 to 20?

def prime_factors(n)
	list = []
	(2..n).each do |k|
		loop do
			break if n % k != 0
			n /= k
			list << k 
		end
		break if n == 1
	end
	list
end

start = Time.now

h = Hash.new(0)
(1..20).each do |i|
	pf = prime_factors(i)
	pf.uniq.each do |p|
		count = pf.count(p)
		h[p] = count if h[p] < count 
	end
end

p h.collect{|k,v| k ** v}.reduce(:*)
p Time.now - start
 # 0.000175 seconds