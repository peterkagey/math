def factorial(n)
	return 1 if n == 0
	(1..n).reduce(:*)
end

def factorial2(n)
	k = 1
	(1..n).each {|i| k *= i}
	k
end

def factorial3(n)
	k = 1
	loop do
		k *= n
		n -= 1
		break if n == 1
	end
	k
end

def factorial_recursion(n)
	return 1 if n == 0
	n * factorial2(n-1)
end
