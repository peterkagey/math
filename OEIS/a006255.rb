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

def perfect_square?(n); (Math.sqrt(n).to_i)**2 == n end

def prime_factors(n, primes) # prime_factors(12, primes) = { 2=>2, 3=>1 }
  factors_hash = Hash.new(0)
  primes.each do |k|
    factors_hash[k] = 0
    while n % k == 0 do
      n /= k
      factors_hash[k] += 1
    end
    break if n == 1
  end
  factors_hash
end

def product_ary_is_square?(ary, primes)
  return true if ary == []
  factors_hash = Hash.new(0)
  ary.each do |n|
    prime_factors(n, primes).each do |k,v|
      factors_hash[k] += v
    end
  end
  return false if factors_hash.select { |k,v| v % 2 == 1 }.length > 0
  true
end

def sieve_of_eratosthenes(n) # finds all primes less than n
  threshold = Math.sqrt(n).to_i
  bool_arry = [false, false] + [true] * (n-1)

  p = 2
  while p < threshold do
    (p**2..n).step(p).each { |i| bool_arry[i] = false }
    (p+1..threshold).each { |k| p = k; break if bool_arry[p] }
  end
  bool_arry.each_index.select { |i| bool_arry[i] }
end

def f(n, primes)
  h = prime_factors(n, primes).sort_by { |k,v| k }
  ("%-#{primes.length}s" % h.collect { |x| x[1] % 2 }.join).gsub(/ /,"0")
end

def xor(ary1, ary2)
  return "array lengths don't match" unless ary1.length == ary2.length
  (0...ary1.length).collect do |i|
    ary1[i] == ary2[i] ? 0 : 1
  end
end

ps = sieve_of_eratosthenes(5000)

##############################################################################

def first_odd_prime(binary_string, primes)
  primes[binary_string.split("").index("1")]
end

def p_m(matrix)
  matrix.each do |row|
    print row.collect { |e| '%4.4s' % e.to_s }.join+"\n"
  end
end

def consistent?(a)
  a.each do |row|
    return false if row.last == 1 && row[0...-1].uniq == [0]
  end
  return true
end


def reduce(matrix)
  rows = matrix.length
  columns = matrix[0].length
  curr_col = 0
  comp_rows = 0
  r_i = 0

  loop do
    return matrix if curr_col >= columns || comp_rows >= rows

    loop do # goes to next column if current column is all 0's.
      break if matrix[comp_rows...rows].collect { |r| r[curr_col] }.uniq != [0]
      curr_col += 1
      return matrix if curr_col >= columns || comp_rows + 1 >= rows
    end

    (comp_rows...rows).each do |row_i| # changes row index for swap
      (r_i = row_i; break) if matrix[row_i][curr_col] == 1
    end

    # if no swap is going to happen, increment column
    if matrix[comp_rows...rows].collect { |r| r[curr_col] }.uniq != [0]
      matrix[r_i], matrix[comp_rows] = matrix[comp_rows], matrix[r_i]
    end

    (0...rows).each do |row_i| # each row index; clean matrix column
      next if row_i == comp_rows
      if matrix[row_i][curr_col] == 1
        matrix[row_i] = xor(matrix[row_i], matrix[comp_rows])
      end
    end
    comp_rows += 1
    curr_col += 1
  end
end

def interpret_matrix(a, n, primes)
  return [n] if perfect_square?(n)
  a = a.transpose
  labels = ((n+1...n+a.length).to_a + [n])
  oar = a[-1]
  terms = (0...a.length).collect do |x|
    labels[x] if a[x].count(1) == 1 && oar[a[x].index(1)] == 1
  end
  ary = (terms.compact + [n]).sort
  ary.group_by { |k| f(k, primes) }.collect { |k,v| v.min }.sort
end

def graham(n, ps)
  return n if perfect_square?(n)
  return 2 * n if ps.include?(n) && n > 8
  upper_bound = n <= 8 ? 4*n : 2*n
  a = (n+1..upper_bound).collect { |k| f(k, ps) } << f(n,ps)
  a.collect! { |s| s.split("").map(&:to_i) }
  a = a.transpose.select { |row| row.uniq != [0] }
  sequence = interpret_matrix(reduce(a), n, ps)
  return "==== PID #{n} ====" unless product_ary_is_square?(sequence, ps)
  return sequence.last
end

ps = sieve_of_eratosthenes(2200 * 2 + 200)
start_time = Time.now
solution_array = []
(2..50).each do |m|
  start = Time.now
  ps = sieve_of_eratosthenes(m + 100) if m % 100 == 0
  solution_array << graham(m, ps)
  p [m, solution_array.last, (Time.now-start).to_i, (Time.now-start_time).to_i]
end