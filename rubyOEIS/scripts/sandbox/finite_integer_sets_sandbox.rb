def zero_index_set(k)
  (0...k.bit_length).select { |i| k[i] == 1 }
end

def one_index_set(k)
  (1..k.bit_length).select { |i| k[i - 1] == 1 }
end

def a116417(k)
  int_array = one_index_set(k)
  d = int_array.inject(1, :lcm)
  n = int_array.map { |n| d/n }.inject(0, :+)
  common_divisor = n.gcd(d)
  d/common_divisor
end

def a116416(k)
  int_array = one_index_set(k)
  d = int_array.inject(1, :lcm)
  n = int_array.map { |n| d/n }.inject(0, :+)
  common_divisor = n.gcd(d)
  n/common_divisor
end

def a096111(k)
  one_index_set(k).reduce(:*)
end

def a073642(k)
  zero_index_set(k).reduce(:+)
end

def a064894(k)
  zero_index_set(k).inject(0, :gcd)
end

# A116417: If n = sum{m>=1} 2^(m-1) * b(n,m), where each b(n,m) is 0 or 1 and
# the sum is a finite sum, then a(n) = denominator of sum{m>=1} b(n,m)/m.
def a999995(k)
  # Similar to A116417
  one_index_set(k).inject(1, :lcm)
end

def count_divisors(k)
  (1..k).count { |i| k % i == 0 }
end

t = 0.5 * Math.sqrt(5) + 0.5
s = Math.sqrt(2)

require_relative "../helpers/table"
require_relative "../helpers/xor"

def a000201(n); t = 0.5 * (Math.sqrt(5) + 1); (t * n).to_i end


def x(n, m)
  m * a000201(n) + a000201(m) * n - n * m
end

def foo(j)
  n, k = OEISTable.n_k(j)
  x(n + 1, k + 1)
end

def a101858(j)
  n, k = OEISTable.n_k(j)
  (n + 1) * (k + 1) + a000201(n + 1) * a000201(k + 1)
end

p (0...80).map { |i| foo i }
