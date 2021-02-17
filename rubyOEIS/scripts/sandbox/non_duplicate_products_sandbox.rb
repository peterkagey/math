# (1, 1)
# (1, 2); (2, 1)
# (1, 3); (3, 1)
# (1, 4); (2, 2); (4, 1)
# (1, 5); (5, 1)
# (1, 6); (2, 3); (3, 2); (6, 1)
# (1, 7); (7, 1)
# (1, 8); (2, 4); (4, 2); (8, 1)
# (1, 9); (3, 3); (9, 1)
# (1, 10); (2, 5); (5, 2); (10, 1)

# 1, 1, 2, 2, 3, 3, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1
# beats
# 1, 1, 2, 3, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1

# FULLY ENUMERATED
# * 1:  [1]
# * 2:  [1, 1]
# ? 3:  [1, 1, 2]
# * 4:  [1, 1, 2, 1]
# ? 5:  [1, 1, 2, 2, 1]
# * 6:  [1, 1, 2, 1, 3, 1]
# * 7:  [1, 1, 2, 2, 1, 3, 1]
# * 8:  [1, 1, 2, 1, 3, 1, 4, 1]
# * 9:  [1, 1, 2, 2, 1, 3, 1, 4, 1]
# ? 10: [1, 1, 2, 1, 3, 1, 4, 1, 5, 1]
# * 11: [1, 1, 2, 2, 1, 3, 1, 4, 1, 5, 1]
# PARTIALLY ENUMERATED:
# ? 12: [1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6, 1] -- Missing (2, 2)
# * 13: [1, 1, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1]
# ? 14: [1, 1, 2, 1, 3, 2, 3, 1, 4, 1, 5, 1, 6, 1] -- Missing (2, 2)
# * 15: [1, 1, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1]
# ? 16: [1, 1, 2, 1, 3, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1] -- Missing (2, 2)
# * 17: [1, 1, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1]
# ? 18:
# * 19: [1, 1, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1]
# ? 20:
# * 21: [1, 1, 2, 4, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1]
# * 22: [1, 1, 2, 4, 2, 1, 3, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1]
# * 23: [1, 1, 2, 4, 2, 1, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1]
# * 24: [1, 1, 2, 4, 2, 1, 3, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1]
# ? 25: -- Missing (3, 3)?
# * 26: [1, 1, 2, 4, 2, 1, 3, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1, 10, 1]
# ? 27: -- Missing (3, 3)?
# * 28: [1, 1, 2, 5, 2, 4, 2, 1, 3, 3, 2, 2, 3, 1, 4, 1, 5, 1, 6, 1, 7, 1, 8, 1, 9, 1, 10, 1]

# Given A259280 strings with no repeating sub-strings:

# Conjecture: A(A054519(n)) = Product(n**A000005(n)/2)
# (1..n).map { |i| i**(A032741(n)+1)/2 }.reduce(:*)


class Sandbox

  def dominoes_of_given_product(k)
    divisors = (1..Math.sqrt(k)).select { |i| k % i == 0 }
    divisors.flat_map { |d| [[d, k/d], [k/d, d]] }.uniq
  end

  def all_dominoes_up_to(k)
    (1..k).flat_map { |i| dominoes_of_given_product(i) }
  end

  def valid_domino_string?(domino_string)
    (1...domino_string.length).all? do |i|
      domino_string[i - 1].last == domino_string[i].first
    end
  end

  def collapse(valid_array)
    valid_array.map { |domino| domino.first } << valid_array.last.last
  end

  def domino_strings(length, max_product)
    upper_bound = Float::INFINITY
    valid_arrays = all_dominoes_up_to(max_product).permutation(length - 1).each do |dom_str|
      p collapse(dom_str) if valid_domino_string?(dom_str)
      end
    end
    valid_arrays.each { |valid_array| p collapse(valid_array)}
  end

end

def ary_product(ary)
  p1 = ary.reduce(:*)
  p pair_products = ary[0...-1].zip(ary[1..-1]).map { |pair| pair.reduce(:*) }
  p2 = pair_products.each_slice(2).select { |slice| slice.length == 2 }.map(&:last).reduce(:*)
  p3 = pair_products.each_slice(2).map(&:first).reduce(:*)
  [p1, p2, p3]
end


# (1, 1)
# (1, 2); (2, 1)
# (1, 3); (3, 1)
# (1, 4); (2, 2); (4, 1)
# (1, 5); (5, 1)
# (1, 6); (2, 3); (3, 2); (6, 1)
# (1, 7); (7, 1)
# (1, 8); (2, 4); (4, 2); (8, 1)
# (1, 9); (3, 3); (9, 1)
# (1, 10); (2, 5); (5, 2); (10, 1)

# ASSUME: n <- [A054519(k)...A054519(k + 1)]
# if tau(k + 1).even?
#   # then we're defined for A054519(k) + 2j for j <- [0..tau(k + 1)/2]
#   case n - A054519(k)
# else # tau(k + 1) is odd
#   # then we're defined for all terms in here.
# k = (0..Float::INFINITY).find { |i| n <= a054519(i) }


[
 [1, 2],
 [2, 2],
 [1, 2],
 [2, 3],
 [1, 3],
 [3, 2],
 [2, 2],
 [1, 2],
 [2, 4],
 [1, 4],
 [4, 2],
 [3, 2],
 [2, 2],
 [1, 2],
 [2, 4],
 [1, 4],
 [4, 3],
 [3, 3],
 [2, 3],
 [1, 3],
 [3, 4],
 [2, 4],
 [1, 4],
 [4, 2],
 [3, 2],
 [2, 2],
 [1, 2],
 [2, 6]]
