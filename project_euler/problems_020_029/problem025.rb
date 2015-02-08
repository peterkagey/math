# The Fibonacci sequence is defined by the recurrence relation:

# Fn = Fn−1 + Fn−2, where F1 = 1 and F2 = 1.
# Hence the first 12 terms will be:

# F1 = 1
# F2 = 1
# F3 = 2
# F4 = 3
# F5 = 5
# F6 = 8
# F7 = 13
# F8 = 21
# F9 = 34
# F10 = 55
# F11 = 89
# F12 = 144
# The 12th term, F12, is the first term to contain three digits.

# What is the first term in the Fibonacci sequence to contain 1000 digits?

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