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

def perfect_square?(n)
    (Math.sqrt(n).to_i)**2 == n
end

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
    ("%-#{primes.length}s" % h.collect{|x| x[1] % 2 == 0 ? 0 : 1}.join).gsub(/ /,"0")
end

def xor(ary1, ary2)
    return "array lengths don't match" unless ary1.length == ary2.length
    (0...ary1.length).collect do |i|
        ary1[i] == ary2[i] ? 0 : 1
    end
end

ps = sieve_of_eratosthenes(2000)

##############################################################################

def first_odd_prime(binary_string, primes)
    primes[binary_string.split("").index("1")]
end

def p_m(matrix)
    matrix.each do |row|
        print row.collect{|e| '%4.4s' % e.to_s}.join+"\n"
    end
end

def consistent?(a)
    a.each do |row|
        return false if row.last == 1 && row[0...-1].uniq == [0]
    end
    return true
end


def almost_rref(matrix)
    rows = matrix.length
    columns = matrix[0].length
    current_column = 0
    completed_rows = 0
    r_i = 0

    loop do
        return matrix if current_column >= matrix[0].length || completed_rows >= matrix.length

        loop do # goes to next column if current column is all 0's.
            if (completed_rows...matrix.length).collect{|row| matrix[row][current_column]}.uniq == [0]
                current_column += 1
                return matrix if current_column >= matrix[0].length || completed_rows + 1 >= matrix.length
            else
                break
            end
        end

        (completed_rows...matrix.length).each do |row_index| # changes row index for swap
            (r_i = row_index; break) if matrix[row_index][current_column] == 1
        end

        # if no swap is going to happen, increment column
        if matrix[completed_rows...matrix.length].collect{|r| r[current_column]}.uniq != [0]
            matrix[r_i], matrix[completed_rows] = matrix[completed_rows], matrix[r_i]       
        end

        (0...matrix.length).each do |row_index| # each row index; clean matrix column
            next if row_index == completed_rows
            matrix[row_index] = xor(matrix[row_index], matrix[completed_rows]) if matrix[row_index][current_column] == 1
        end
        completed_rows += 1
        current_column += 1
    end
end

def graham(n, ps)
    return n if perfect_square?(n)
    fop = first_odd_prime(f(n, ps), ps)
    (n+fop..4*n).each do |i|
        a = (n+1..i).collect{|k| f(k, ps)} + [f(n,ps)]
        a.collect!{|s| s.split("").map(&:to_i)}
        a = a.transpose.select{|row| row.uniq != [0]}
        x = almost_rref(a)
        return a if consistent? x
    end
end

def interpret_this_matrix(a, n, primes)
    return [n] if perfect_square?(n)
    a = a.transpose
    labels = ((n+1...n+a.length).to_a + [n])
    oar = xor(a[-1], a[-2])
    terms = (0...a.length).collect do |x|
        labels[x] if a[x].count(1) == 1 && oar[a[x].index(1)] == 1
    end
    ary = (terms.compact + [n, n+a.length-1]).sort
    ary.group_by{|k| f(k, primes)}.collect{|k,v| v.min}.sort
end

n = 1
loop do
    p interpret_this_matrix(graham(n, ps), n, ps)
    n += 1
end