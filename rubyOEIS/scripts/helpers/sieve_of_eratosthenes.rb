require 'set'

def sieve_of_eratosthenes(n)
  threshold = Math.sqrt(n).to_i + 1
  bool_arry = [false, false] + [true] * (n-1)

  p = 2
  while p # sieve out composites
    (p**2..n).step(p).each { |i| bool_arry[i] = false }
    p = (p+1..threshold).find { |k| bool_arry[k] }
  end

  # actually faster than
  #   bool_arry.each_index.select { |i| bool_arry[i] }
  # and its variants
  x = SortedSet.new
  bool_arry.each_index.each { |i| x << i if bool_arry[i] }
  x
end
