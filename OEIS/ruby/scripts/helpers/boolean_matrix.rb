require_relative '../graham/a248663'
require 'prime'

# Speed this up by making it halt as soon as a solution is found (instead of
# reducing the whole matrix).
class BooleanMatrix
  # a boolean matrix is an array of integers where each integer is a binary
  # representaion of a row.
  # Example:
  #   [0 1 0 0]
  #   [0 0 0 0]
  #   [1 1 0 1]
  # would be represented by the array [0b0100, 0b0000, 0b1101] == [4, 0, 13]

  # the method for dealing with these is to transpose, do operations, then
  # transpose back.

  attr_accessor :column_count, :row_count, :matrix

  def initialize(matrix, opts={})
    @matrix = matrix
    @column_count = opts[:column_count]
    @column_count ||= @matrix.map { |row| row.bit_length }.max
    @row_count = opts[:row_count] || matrix.length
  end

  def self.factor_parity(n)
    OEIS.a248663(n)
  end

  def self.construct(n)
    upper_bound = (n > 3) ? (2 * n) : (4 * n)
    pi_n = Prime.each(n).to_a.length
    k = (1 << pi_n) - 1 # 0b1111...111 with pi(n) 1s.
    x = (n+1..upper_bound).collect { |i| factor_parity(i) & k}
    x <<= factor_parity(n)
    BooleanMatrix.new(x).transpose
  end

  def transpose
    x = (0...@column_count).collect { |c_i| _read_column(c_i) }
    BooleanMatrix.new(x, {column_count: @row_count, row_count: @column_count})
  end

  def format(row)
    "[" + row.to_s(2).rjust(@column_count, '0').split('').join(' ') + "]"
  end

  def inspect
    _rref.matrix.collect { |row| format row }.join("\n")
  end

  def interpret
    # only finds a solution when BooleanMatrix.construct(n) has n >= 4.
    m = _rref.transpose.matrix
    terms = [-1]
    terms += _bit_indices(m.last).collect { |i| m.index(i) }
    terms.map { |x| x + @column_count }
  end

  def rank
    reduced = _rref.matrix
    reduced.length - reduced.count(0)
  end

  def dim_null_space
    _rref.matrix.count(0)
  end

  private

  def _i_j_entry(i, j)
    @matrix[i][@column_count - 1 - j]
  end

  def _read_column(j)
    column_sum = 0
    (0...@row_count).each do |i|
      column_sum <<= 1
      column_sum |= _i_j_entry(i, j)
    end
    column_sum
  end

  def _done_reducing?(curr_col, comp_rows)
    curr_col >= @column_count || comp_rows >= @row_count
  end

  def _swap_rows(r_1, r_2)
    @matrix[r_1], @matrix[r_2] = @matrix[r_2], @matrix[r_1]
  end

  def _swap_to_the_top(column_index, top_row_index)
    # swaps row to place a 1 on the diagonal
    (top_row_index...@row_count).each do |row_index|
      if _i_j_entry(row_index, column_index) == 1
        _swap_rows(row_index, top_row_index)
        return true
      end
    end
    false
  end

  def _clear_column(c_i, top_row_index)
    # Clears any 1s above or below the 'diagonal'.
    (0...@row_count).each do |r_i|
      next if r_i == top_row_index
      @matrix[r_i] ^= @matrix[top_row_index] if _i_j_entry(r_i, c_i) == 1
    end
  end

  def _rref
    r_i, c_i = 0, 0
    (0...column_count).each do |c_i|
      if _swap_to_the_top(c_i, r_i)
        _clear_column(c_i, r_i)
        r_i += 1
      end
      break if _done_reducing?(c_i, r_i)
    end
    self
  end

  def _bit_indices(integer)
    # This returns an array of indices of 1 bits.
    # _bit_indices(0b1101)
    #   >> [0b1000, 0b100, 0b1]
    bits = integer.bit_length
    bit_position_ary = (0...bits).select do |bit_position|
      integer[bit_position] == 1
    end
    bit_position_ary.map { |pos| 1 << pos }.reverse
  end

end

################################################################################

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
# combine some subset of them, using only the beginning of the list

# in other words, we're looking for f(N) XOR f(k_1) XOR ... XOR f(k_n) such
# that f(N) XOR f(k_1) XOR ... XOR f(k_n) == 000000...
# and k_n is minimized.
