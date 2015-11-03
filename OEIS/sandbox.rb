require "/Users/pkagey/personal/math/OEIS/ruby/scripts/helpers/subset_logic.rb"

module Sandbox

  class A067597

    def initialize
      p binary_palindromes
      a = []
      binary_palindromes.each_subset do |subset|
        break if subset.length > 1 && subset[-1] + subset[-2] > 0b111111
        a << subset.reduce(:+)
      end
      p a
      p (0..64).to_a.map { |i| a.count(i) }
    end

    def binary_palindromes
      ary = []
      (1...2**4).each do |i|
        b = i.to_s(2)
        ary << (b + b.reverse)
        ary << (b + b.reverse[1..-1])
      end
      ary.map { |i| i.to_i(2) }.sort
    end

  end

  class A118966Builder
    def self.sequence

      n = 10000
      bool = Array.new(2 * n) { false }

      seq = []
      (1..n).each do |n|
        a_i = bool[n] ? (n + 1)/2 : 2 * n - 1
        bool[a_i] = true
        seq << a_i
      end

      seq

    end
  end
end

module Sandbox2

  # Enumerate all palindromic ordered partitions of that sum to n.

  # define f(k, 2n) where k <- [0, 2^n)


  # for example

  # f(0b000, 6) = [6]
  # f(0b001, 6) = [3, 3]
  # f(0b010, 6) = [2, 2, 2]
  # f(0b011, 6) = [2, 1, 1, 2]
  # f(0b100, 6) = [1, 4, 1]
  # f(0b101, 6) = [1, 2, 2, 1]
  # f(0b110, 6) = [1, 1, 2, 1, 1]
  # f(0b111, 6) = [1, 1, 1, 1, 1, 1]
  # f(0b1111, 6) => error

  class Enum

    def initialize(n)
      # raise "n = #{n} must be even" if n.odd?
      @n = n
      @max_k = 1 << (@n/2)
    end

    def sequence(k) # => [1, 2, 1] or [2, 2] (a palindromic partition of n)
      raise "k = #{k} must be in [0..#{@max_k - 1}]." unless (0...@max_k).include?(k)
      if k.odd?
        x = k.to_s(2).rjust(@n/2, '0').scan(/0*1/).map(&:length)
        result = x + x.reverse
      else
        foo = k/2
        bar = foo.to_s(2).rjust(@n/2 - 1, '0').scan(/0*1/).map(&:length)
        middle_term = @n - bar.inject(0) { |i, sum| sum + i } * 2
        result = bar + [middle_term] + bar.reverse
      end

      @n.odd? ? oddify(result) : result
    end

    def oddify(partition_of_n)
      middle_index = partition_of_n.length/2
      if partition_of_n.length.odd?
        partition_of_n[middle_index] += 1
        partition_of_n
      else
        first_half = partition_of_n[0...middle_index]
        second_half = partition_of_n[middle_index..-1]
        first_half + [1] + second_half
      end
    end

    def all_sequences
      (1...@max_k).map { |i| sequence(i) }
    end

  end

  class PartitionLengthToPalindromes
    def initialize(partition_length_array)
      @partition_length_array = partition_length_array
    end

    def palindromes # => [[2...4], [1...2, 0...2]]
      full_length = @partition_length_array.length
      half_length = @partition_length_array.length/2

      if full_length.even?
        half = @partition_length_array[0...half_length]
      else
        half = @partition_length_array[0..half_length]
      end

      half.each_with_index.map { |len, i| appropriate_enumerator(len, i) }
    end

    def appropriate_enumerator(length, index)
      return (0...2) if length == 1 && index > 0
      min = 1 << length - 1
      max = 1 << length
      (min...max)
    end

  end


  ############################################################

  class EnumArray

    def initialize(enum_array, parity = :even)
      @enum_array = enum_array
      @parity = parity
    end

    def explode_length_2_array(length_2_array)
      new_array = []
      length_2_array.first.flat_map do |a|
        length_2_array.last.map { |b| new_array << [a, b].flatten }
      end
      new_array
    end

    def explode # => [[2, 0], [2, 1], [3, 0], [3, 1]]
      case @enum_array.length
      when 0 then raise "@enum_array appears empty"
      when 1 then return @enum_array.first.map { |c| [c] }
      when 2 then return explode_length_2_array(@enum_array)
      else
        @enum_array = [explode_length_2_array(@enum_array[0..1])] + @enum_array[2..-1]
        explode
      end
    end

    def exploded # => [%w[10 0 0 10], %w[10 1 1 10], %w[11 0 0 11], %w[11 1 1 11]]
      return exploded_even if @parity == :even
      exploded_odd
    end

    def exploded_even
      explode.map do |e|
        first_half = e.map { |i| i.to_s(2) }
        first_half + first_half.reverse
      end
    end

    def exploded_odd
      explode.map do |e|
        first_half = e.map { |i| i.to_s(2) }
        first_half[0...-1] + first_half.reverse
      end
    end

  end


  class PalindromicNumbers

    def initialize(bits)
      @bits = bits
      @partitions = Enum.new(bits).all_sequences
    end

    def even_enum_arrays
      even_sequences = @partitions.select { |ary| ary.length.even? }
      even_sequences.map do |seq|
        PartitionLengthToPalindromes.new(seq).palindromes
      end
    end

    def odd_enum_arrays
      odd_sequences = @partitions.select { |ary| ary.length.odd? }
      odd_sequences.map do |seq|
        PartitionLengthToPalindromes.new(seq).palindromes
      end
    end

    def all_palindromes
      palindromes = []

      even_enum_arrays.each do |enum_array|
        palindromes += EnumArray.new(enum_array, :even).exploded.map(&:join)
      end

      odd_enum_arrays.each do |enum_array|
        palindromes += EnumArray.new(enum_array, :odd).exploded.map(&:join)
      end

      palindromes
    end

  end
end

# module Sandbox3

  def triangle(n)
    n * (n + 1)/2
  end

  def a(n)
    return 0 if n == 0 || n == 1
    a(n - 2) +
    triangle(n) - 1 +  # corner (diagonal symmetry)
    non_symmetric(n) + # non-center edge
    symmetric(n)       # center edge
  end

  def non_symmetric(n)
    return 0 if n < 4
    (0..n/2 - 2).map { |i| n * n - 8 * i - 5 }.reduce(:+)
  end

  def symmetric(n);
    n.even? ? 0 : triangle(n) + 3 - 2 * n
  end

  puts a(2) == 2
  puts a(3) == 5 + 3
  puts a(4) == (2) + 9 + 11
  puts a(5) == (5 + 3) + 14 + 20 + 8

# end

# "Numbers whose binary representation can be partitioned into a palindromic sequence"

# e.g. 1101_2 is in the sequence because [1, 10, 1] is a palindrome with a concatination of 1101_2
# e.g. 1011_2 is not in the sequence because [1, 0, 0], [10, 0] are not palindromes
