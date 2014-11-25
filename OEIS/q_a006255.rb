# http://oeis.org/A006255

# Find N
# N = 126
# 126 = 2 * 3^2 * 7
# 127 = 127
# 128 = 2^7
# 129 = 3 * 43
# 130 = 2 * 5 * 13
# ...
# 504 = 2^3 * 3^2 * 7

# represent each number as a binary string where each bit stands for the 
# parity of the prime

# 1001010... would represent a number whose prime factorization was:
# 1 => 2^(odd)
# 0 => 3^(even)
# 0 => 5^(even)
# 1 => 7^(odd)
# 0 => 11^(even)
# 1 => 13^(odd)
# 1 => 17^(odd)

# For example, 2 * 7 * 13 OR 2^3 * 7 * 13^101
# Thus f(2*7*13) = 1001010...

# Now we have a list of binary strings, and we want to find the way to XOR 
# combine some subset of them, using only the beginning* of the list

# in other words, we're looking for f(N) XOR f(k_1) XOR ... XOR f(k_n) such
# that f(N) XOR f(k_1) XOR ... XOR f(k_n) == 000000...
# and k_n is minimized.

# This is at least a computationally fast way of iterating through the list.
# (Unfortunately, it doesn't cut down on the problem's complexity)

def prime_factors(n, primes) # prime_factors(12, primes) = {2=>2, 3=>1}
    prime_factors_hash = Hash.new(0)
    primes.each do |k|
    	prime_factors_hash[k] = 0
        loop do
            break if n % k != 0
            n /= k
            prime_factors_hash[k] += 1
        end
        break if n == 1
    end
    prime_factors_hash
end

def sieve_of_eratosthenes(n) # finds all primes less than n
    threshold = Math.sqrt(n).to_i
    bool_arry = [false, false] + [true] * (n-1)
    
    p = 2
    loop do
        (p**2..n).step(p).each { |i| bool_arry[i] = false }
        (p+1..threshold).each { |k| p = k; break if bool_arry[p] }
        break if p >= threshold
    end
    bool_arry.each_index.select{ |i| bool_arry[i] }
end

def f(n, primes)
	h = prime_factors(n, primes).sort_by{|k,v| k}
	h.collect{|x| x[1] % 2 == 0 ? 0 : 1}.join
end

p f(70, sieve_of_eratosthenes(70))
p f(70, sieve_of_eratosthenes(70)).to_i(2)