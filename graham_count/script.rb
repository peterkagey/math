require_relative '../OEIS/scripts/a248663'
require_relative '../OEIS/scripts/a006255'

class GrahamCounter

  attr_reader :n

  PARITY_ARRAY = [0, 0, 1, 2, 0, 4, 3, 8, 1, 0, 5, 16, 2, 32, 9, 6, 0, 64, 1, 128, 4, 10, 17, 256, 3, 0, 33, 2, 8, 512, 7, 1024, 1, 18, 65, 12, 0, 2048, 129, 34, 5, 4096, 11, 8192, 16, 4, 257, 16384, 2, 0, 1, 66, 32, 32768, 3, 20, 9, 130, 513, 65536, 6, 131072, 1025, 8, 0, 36, 19, 262144, 64, 258, 13, 524288, 1, 1048576, 2049, 2, 128, 24, 35, 2097152, 4, 0, 4097, 4194304, 10, 68, 8193, 514, 17, 8388608, 5, 40, 256, 1026, 16385, 132, 3, 16777216, 1, 16, 0, 33554432, 67, 67108864, 33, 14, 32769, 134217728, 2, 268435456, 21, 2050, 8, 536870912, 131, 260, 512, 32, 65537, 72, 7, 0, 131073, 4098, 1024, 4, 9, 1073741824, 1, 8194, 37, 2147483648, 18, 136, 262145, 6, 65, 4294967296, 259, 8589934592, 12, 16386, 524289, 48, 0, 516, 1048577, 2, 2048, 17179869184, 3, 34359738368, 129, 64, 25, 1028, 34, 68719476736, 2097153, 32770, 5, 264, 1, 137438953472, 4096, 22, 4194305, 274877906944, 11, 0, 69, 128, 8192, 549755813888, 515, 8, 16, 65538, 8388609, 1099511627776, 4, 2199023255552, 41, 131074, 257, 2052, 1027, 80, 16384, 10, 133, 4398046511104, 2, 8796093022208, 16777217, 38, 0, 17592186044416, 17, 35184372088832, 1]

  def initialize(n)
    @n = n
  end

  def g(n)
    @grahams ||= OEIS.a006255(n)
  end

  def prime_parity(k)
    PARITY_ARRAY[k]
  end

  def permutation_count
    counter = 0
    permutation_count = 1 << nonsquare_interior_terms.length
    (0...permutation_count).each do |i|
      subset = ith_subset(i)
      next unless subset_forms_perfect_square?(subset)
      counter += 1
    end
    counter * (1 << number_of_interior_perfect_squares)
  end

  def count_all_valid_sequences
    counter = 0
    total_sequences = 1 << nonsquare_interior_terms.length
    (0...total_sequences).each do |i|
      subset = ith_subset(i)
      next unless subset_forms_perfect_square?(subset)
      puts "#{n}: #{i}/#{total_sequences}"
      counter += 1
    end
    total = counter * (1 << number_of_interior_perfect_squares)
    puts "g(#{n}) = #{g(n)}"
    if nonsquare?(n)
      puts "a(#{n}) = #{total}"
    else
      puts "a(#{n}) = 1"
    end

  end

  def format_array_to_string(subset)
    ([n] + subset + [g(n)]).join(' ') + "\n"
  end

  def nonsquare_interior_terms
    @nonsquare_interior_terms ||= (n+1...g(n)).to_a.select { |i| nonsquare?(i) && nonprime?(i) }
  end

  def nonsquare?(i)
    Math.sqrt(i).round**2 != i
  end

  def nonprime?(i)
    !Prime.prime?(i)
  end

  # Example: binary_to_indices(0b1101)
  # >> [0, 2, 3]
  def binary_to_indices(k)
    bit_length = k.to_s(2).length
    (0...bit_length).select { |i| one_at_bit_position(k, i) }
  end

  # Checks if the ith bit of k is a 1.
  def one_at_bit_position(k, i)
    k >> i & 1 > 0
  end

  def ith_subset(i)
    binary_to_indices(i).map { |index| nonsquare_interior_terms[index]}
  end

  # fast way to determine if
  #   n * product(subset) * g(n)
  # is a perfect square.
  def subset_forms_perfect_square?(subset)
    subset.map { |k| PARITY_ARRAY[k] }.reduce(:^) == target_xor
  end

  def target_xor
    @target_xor ||= PARITY_ARRAY[n] ^ PARITY_ARRAY[g(n)]
  end

  def number_of_interior_perfect_squares
    Math.sqrt(g(n)).to_i - Math.sqrt(n).to_i
  end

end
