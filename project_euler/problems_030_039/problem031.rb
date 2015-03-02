# In England the currency is made up of p, £, and pence, p, and there are
# eight coins in general circulation:

# 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# It is possible to make £2 in the following way:

# 1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
# How many different ways can £2 be made using any number of coins?

start = Time.now

def amount_left(p = 0, f = 0, t = 0, te = 0, fi = 0)
	200 - 100 * p - 50 * f - 20 * t - 10 * te - 5 * fi
end

total = 0
(0..200/100).each do |p|
	al = amount_left(p)
	(0..al/50).each do |f|
		al = amount_left(p, f)
		(0..al/20).each do |t|
			al = amount_left(p, f, t)
			(0..al/10).each do |te|
				al = amount_left(p, f, t, te)
				(0..al/5).each do |fi|
					total += amount_left(p, f, t, te, fi)/2 + 1
				end
			end
		end
	end
end

p total + 1 # for the £2 coin
p Time.now - start

# 73682
# 0.000959 seconds

# I can't think of a way to make this much uglier, but it's fast and it works.
