# Starting in the top left corner of a 2×2 grid, and only being able to move 
# to the right and down, there are exactly 6 routes to the bottom right corner.

# How many such routes are there through a 20×20 grid?

start = Time.now

def factorial(n)
	return 1 if n == 0
	(1..n).reduce(:*)
end

def n_choose_k(n,k)
	factorial(n)/factorial(k)/factorial(n-k)
end

p n_choose_k(40,20)
p Time.now-start
# 8.3e-05 seconds