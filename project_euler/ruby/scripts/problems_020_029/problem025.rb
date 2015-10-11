start = Time.now

def sqrt(n)
	Math.sqrt(n)
end

def fib(n) # for reference; uses formula for nth term of sequence
	phi = (1 + Math.sqrt(5))/2
	( phi**n - (-phi)**(-n) )/sqrt(5)
end

def log(k, n = Math.exp(1))
	Math.log(k)/Math.log(n)
end

def fib_digits(n)
# Assumes phi^(-n) is negligible.
	phi = (1 + 5**0.5) / 2
	(n * log(phi, 10) - log(5, 10)/2 + 1).floor
end

n = 1
loop do
	break if fib_digits(n) >= 1000
	n += 1
end

p n
p Time.now - start

# 4782
# 0.010189 seconds
