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

ps = sieve_of_eratosthenes(1000)

##############################################################################

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


def reduced_row_eschelon_form(matrix)
    rows = matrix.length
    columns = matrix[0].length
    current_column = 0
    completed_rows = 0
    r_i = 0

    loop do
        return matrix if current_column >= matrix[0].length || completed_rows + 1 >= matrix.length

        loop do # goes to next column if current column is all 0's.
            if (completed_rows...matrix.length).collect{|row| matrix[row][current_column]}.uniq == [0]
                current_column += 1
                return matrix if current_column >= matrix[0].length || completed_rows + 1 >= matrix.length
            else
                break
            end
        end

        (completed_rows...matrix.length).each do |xxx| # changes row index for swap
            (r_i = xxx; break) if matrix[xxx][current_column] == 1
        end

        # if no swap is going to happen, increment column
        if matrix[completed_rows...matrix.length].collect{|r| r[current_column]}.uniq != [0]
            matrix[r_i], matrix[completed_rows] = matrix[completed_rows], matrix[r_i]       
        end

        (0...matrix.length).each do |xxx| # each row index; clean matrix column
            next if xxx == completed_rows
            matrix[xxx] = xor(matrix[xxx], matrix[completed_rows]) if matrix[xxx][current_column] == 1
        end
        completed_rows += 1
        current_column += 1
    end
end

def graham(n, ps)
    return n if perfect_square?(n)
    (n+2..4*n).each do |i|
        a = (n+1..i).collect{|k| f(k, ps)} + [f(n,ps)]
        a.collect!{|s| s.split("").map(&:to_i)}
        a = a.transpose.select{|row| row.uniq != [0]}
        x = reduced_row_eschelon_form(a)
        return i if consistent? x
    end
end


def graham2(n, ps)
    return n if 
    (n+2..4*n).each do |i|
        a = (n+1..i).collect{|k| f(k, ps)} + [f(n,ps)]
        a.collect!{|s| s.split("").map(&:to_i)}
        a = a.transpose.select{|row| row.uniq != [0]}
        x = reduced_row_eschelon_form(a)
        return a if consistent? x
    end
end

def interpret_this_matrix(a, n)
    return [n] if perfect_square?(n)
    a = a.transpose
    labels = ((n+1...n+a.length).to_a + [n])
    oar = xor(a[-1], a[-2])
    terms = (0...a.length).collect do |x|
        labels[x] if a[x].count(1) == 1 && oar[a[x].index(1)] == 1
    end
    return (terms.compact + [n, n+a.length-1]).sort
end

a006255 = {1=>1, 2=>6, 3=>8, 4=>4, 5=>10, 6=>12, 7=>14, 8=>15, 9=>9, 10=>18, 11=>22, 12=>20, 13=>26, 14=>21, 15=>24, 16=>16, 17=>34, 18=>27, 19=>38, 20=>30, 21=>28, 22=>33, 23=>46, 24=>32, 25=>25, 26=>39, 27=>35, 28=>40, 29=>58, 30=>42, 31=>62, 32=>45, 33=>44, 34=>51, 35=>48, 36=>36, 37=>74, 38=>57, 39=>52, 40=>50, 41=>82, 42=>56, 43=>86, 44=>55, 45=>60, 46=>69, 47=>94, 48=>54, 49=>49, 50=>63, 51=>68, 52=>65, 53=>106, 54=>70, 55=>66, 56=>72, 57=>76, 58=>87, 59=>118, 60=>75, 61=>122, 62=>93, 63=>77, 64=>64, 65=>78, 66=>80, 67=>134, 68=>85, 69=>92, 70=>84, 71=>142, 72=>88, 73=>146, 74=>111, 75=>90, 76=>95, 77=>96, 78=>91, 79=>158, 80=>98, 81=>81, 82=>123, 83=>166, 84=>105, 85=>102, 86=>129, 87=>116, 88=>99, 89=>178, 90=>110, 91=>117, 92=>115, 93=>124, 94=>141, 95=>114, 96=>108, 97=>194, 98=>112, 99=>120, 100=>100, 101=>202, 102=>136, 103=>206, 104=>130, 105=>125, 106=>159, 107=>214, 108=>126, 109=>218, 110=>132, 111=>148, 112=>128, 113=>226, 114=>133, 115=>138, 116=>145, 117=>130, 118=>177, 119=>136, 120=>135, 121=>121, 122=>183, 123=>164, 124=>155, 125=>140}

(1..1000).each do |i|
    p g = graham(i, ps)
    # p int = interpret_this_matrix(g, i)
    # g = int.last
    # print "===================================== #{g == a006255[i]}\n" unless g == a006255[i] 
end

# p interpret_this_matrix(graham2(90, ps), 90)
# print ((114..115).to_a + [113]).map{|x| '%4.4s' % x.to_s}.join, "\n"