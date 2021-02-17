class BraxtonBuilder

  attr_reader :strings

  def initialize
    @max_term = 5
    @substring_length = 2
    @strings = [
      [1, 1]
    ]
  end

  def possible_extensions(array)
    (1..@max_term).map { |i| array + [i] }.select { |ary| !contains_substring?(array, ary[-@substring_length, @substring_length]) }
  end

  def starts_with?(array, subarray)
    # This doesn't feel very optimized!
    subarray.length <= array.length && array[0, subarray.length] == subarray
  end

  def contains_substring?(array, substring)
    return false if substring.length > array.length
    starts_with?(array, substring) || contains_substring?(array[1..-1], substring)
  end

  def next_generation
    @strings = @strings.flat_map { |ary| possible_extensions(ary) }
  end

end

# [1, 1, 1],
# [1, 1, 1, 2],
# [1, 1, 1, 2, 1],
# [1, 1, 1, 2, 1, 1],
# [1, 1, 1, 2, 2, 1, 1],
# [1, 1, 1, 2, 1, 1, 3, 1],
# [1, 1, 1, 2, 1, 1, 3, 1, 1],
# [1, 1, 1, 2, 1, 2, 2, 2, 1, 1],
# [1, 1, 1, 2, 1, 1, 3, 1, 2, 2, 1],
# [1, 1, 1, 2, 1, 2, 2, 1, 1, 3, 1, 1],
# [1, 1, 1, 2, 1, 2, 2, 2, 1, 1, 3, 1, 1],
# [1, 1, 1, 2, 1, 1, 3, 1, 2, 2, 1, 2, 3, 1],
# [1, 1, 1, 2, 1, 1, 3, 1, 2, 2, 1, 2, 3, 1, 1],
# [1, 1, 1, 2, 1, 1, 3, 1, 2, 2, 2, 1, 2, 3, 1, 1],
# [1, 1, 1, 2, 1, 1, 3, 1, 2, 2, 1, 2, 3, 1, 3, 2, 1],

  def variance(list)
    mean = Rational(list.reduce(:+))/list.length
    list.map { |i| (i - mean)**2 }.reduce(:+)/list.length
  end

x = BraxtonBuilder.new
100.times {
  x.next_generation
  p x.strings.sort_by { |ary| [variance(ary), ary] }.first
}



##############################################################################
# Here is some numerical data if we intend to generalize to minimum sums with no repeated substrings of length 3.

# S_min,3(1)  = 1  via [1]
# S_min,3(2)  = 2  via [1, 1]
# S_min,3(3)  = 3  via [1, 1, 1]
# S_min,3(4)  = 5  via [1, 1, 1, 2]
# S_min,3(5)  = 6  via [1, 1, 1, 2, 1]
# S_min,3(6)  = 7  via [1, 1, 1, 2, 1, 1]
# S_min,3(7)  = 9  via [1, 1, 1, 2, 2, 1, 1]
# S_min,3(8)  = 11 via [1, 1, 1, 2, 1, 1, 3, 1]
# S_min,3(9)  = 12 via [1, 1, 1, 2, 1, 1, 3, 1, 1]
# S_min,3(10) = 14 via [1, 1, 1, 2, 1, 2, 2, 2, 1, 1]
# S_min,3(11) = 16 via [1, 1, 1, 2, 1, 1, 3, 1, 2, 2, 1]
# S_min,3(12) = 17 via [1, 1, 1, 2, 1, 2, 2, 1, 1, 3, 1, 1]
# S_min,3(13) = 19 via [1, 1, 1, 2, 1, 2, 2, 2, 1, 1, 3, 1, 1]
# S_min,3(14) = 22 via [1, 1, 1, 2, 1, 1, 3, 1, 1, 4, 1, 2, 2, 1]
# S_min,3(15) = 23 via [1, 1, 1, 2, 1, 1, 3, 1, 2, 2, 1, 2, 3, 1, 1]
# S_min,3(16) = 25 via [1, 1, 1, 2, 1, 1, 3, 1, 2, 2, 2, 1, 2, 3, 1, 1]
# S_min,3(17) = 28 via [1, 1, 1, 2, 1, 1, 3, 1, 1, 4, 1, 2, 2, 1, 2, 3, 1]
# S_min,3(18) = 29 via [1, 1, 1, 2, 1, 1, 3, 1, 2, 2, 1, 2, 3, 1, 1, 4, 1, 1]
# S_min,3(19) = 31 via [1, 1, 1, 2, 1, 1, 3, 1, 2, 2, 2, 1, 2, 3, 1, 1, 4, 1, 1]

# We can use a very similar lower-bound argument to S_min,2.
# (
#   2*a_k + 2*a_N +
#   a_k+1 + a_N-1 +
#   sum_{k=1}^{N-2}(a_k + a_k+1 + a_k+2)
# )/3

# Which, for N > 2, is bounded below by:
# ceil(2 + sum_{k=0}^{N-3}(A056556(n) + 3)/3)

# But (unsurprisingly) S_min,3 doesn't attain the lower bound the way that S_min,2 does. It gets pretty close however:

# 3  <= S_min,3(3)  = 3
# 4  <= S_min,3(4)  = 5
# 5  <= S_min,3(5)  = 6
# 7  <= S_min,3(6)  = 7
# 8  <= S_min,3(7)  = 9
# 10 <= S_min,3(8)  = 11
# 12 <= S_min,3(9)  = 12
# 13 <= S_min,3(10) = 14
# 15 <= S_min,3(11) = 16
# 17 <= S_min,3(12) = 17
# 19 <= S_min,3(13) = 19
# 21 <= S_min,3(14) = 22
# 23 <= S_min,3(15) = 23
# 25 <= S_min,3(16) = 25
# 27 <= S_min,3(17) = 28
