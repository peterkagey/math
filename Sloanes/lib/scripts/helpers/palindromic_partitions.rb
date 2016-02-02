class PalindromicPartitions

  def part(n)
    c = 2**(n/2)
    return (1...c).map { |k| even_partitions(n, k) } if n.even?
    (1...c).map { |k| odd_partitions(n, k) }
  end

  private

  def odd_partitions(n, k)
    ary = even_partitions(n - 1, k)
    midpoint = ary.length/2
    k.odd? ? ary.insert(midpoint, 1) : ary[midpoint] += 1
    ary
  end

  def even_partitions(n, k)
    ones_indices = (0..k).select { |i| k[i] == 1 } + [n/2]
    first_differences = ones_indices.each_cons(2).map { |a, b| b - a }
    middle_term = k.odd? ? [] : [ones_indices.min * 2]

    first_differences.reverse + middle_term + first_differences
  end
end
