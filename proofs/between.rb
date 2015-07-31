# This script is to support a proof that A006255(n) > A072905(n) for all n.

# square_between(l, k) tests if there exists some k*h^2 between 2*l**2 and 2*(l+1)**2
def square_between(l, k)
  greatest_integer_below_a072905_n(l, k) >= least_integer_above_n(l, k)
end

def least_integer_above_n(l, k)
  # n = 2 * l^2
  # a is the least integer such that k * a^2 > n
  a = (l * Math.sqrt(2.0/k) + 1).to_i
end

def greatest_integer_below_a072905_n(l, k)
  # n = 2 * l^2
  # b is the greatest integer such that k * b^2 < A072905(n)
  b = ((l + 1) * Math.sqrt(2.0/k) - 1).ceil
end

def print_between(l, k)
  [
    greatest_integer_below_a072905_n(l, k),
    least_integer_above_n(l, k)
  ]
end

def pair_between_n_and_a072905_n?(l, k)
  square_between(l, k) && square_between(l, 2*k)
end

def coefficient_pairs_between_n_and_a072905_n(l)
  # finds all coefficients k such that there exists h,j:
  # 2 * l^2 <     k * h^2     < 2 * (l+1)^2
  #                                             AND
  # 2 * l^2 <   2 * k * j^2   < 2 * (l+1)^2
  max = (l + 1)**2 + 5
  (1..max).to_a.select { |k| pair_between_n_and_a072905_n?(l, k) }
end

def there_exists_a_coefficient_pair_between_n_and_a072905?(l)
  max = (l + 1)**2 + 5
  (3..max).each do |k|
    return true if pair_between_n_and_a072905_n?(l, k)
  end
  false
end

# OEIS candidate!
# a(n)

# { m :
# there exist two perfect squares k^2 and h^2 such that
#   2*n^2 <     m * k^2 < 2*(n+1)^2
#                                     AND
#   2*n^2 < 2 * m * h^2 < 2*(n+1)^2
# }

# For example a(12) = 3 because there are three such coefficients:
#   {3, 6, 37}
#   1) a) 2 * 12^2 <     3 * 10^2 < 2 * 13^2
#      b) 2 * 12^2 < 2 * 3 * 7^2  < 2 * 13^2

#   2) a) 2 * 12^2 <     6 * 7^2  < 2 * 13^2
#      b) 2 * 12^2 < 2 * 6 * 5^2  < 2 * 13^2

#   3) a) 2 * 12^2 <     37 * 3^2  < 2 * 13^2
#      b) 2 * 12^2 < 2 * 37 * 2^2  < 2 * 13^2

def print_number_of_pairs(a, b)
  (a...b).each do |i|
    pairs = coefficient_pairs_between_n_and_a072905_n(i)
    puts "#{i} #{pairs.length}"
  end
end

def print_scatterplot_coordinates(a, b)
  (a...b).each do |i|
    pairs = coefficient_pairs_between_n_and_a072905_n(i)
    pairs.each { |pair| puts "#{i} #{pair}"}
  end
end

print_number_of_pairs(1, 10000)
# print_scatterplot_coordinates(12,13)
# p print_between(12, 37*2)
