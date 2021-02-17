class Integer
  def is_power_of?(n)
    (self**(1.0/n)).round**n == self
  end
end

def increasing_sequences_starting_with(n)
  (0...Float::INFINITY).each do |i|
    seq = [n] + nth_increasing_sequence(i).map { |k| k + n + 1 }
    yield(seq)
  end
end

def nth_increasing_sequence(n)
  (0...n.bit_length).select { |i| n[i] == 1 }
end


# all_powers_for_sequence([8, 9])
# => [
#   [7^1, 8^1, 9^1]
#   [7^1, 8^1, 9^2]
#   [7^1, 8^1, 9^3]
#   [7^1, 8^2, 9^1]
#   [7^1, 8^2, 9^2]
#   ...
# ]

def all_powers_for_sequence(seq, base)
  (0...base**(seq.length-1)).map { |i|
    tail_exponents = i
    .to_s(base)
    .rjust(seq.length - 1, '0')
    .split("")
    .map(&:to_i)
    .map(&:next)

    seq
      .zip([1] + tail_exponents)
      .map { |b, p| b**p }
  }
end

def a(n, b)
  increasing_sequences_starting_with(n) do |bases|
    all_powers_for_sequence(bases, b).map { |s| p s; return s if s.reduce(:*).is_power_of?(b) }
  end
end

# a(1, 4)  = 1   #  1                     = 1^4
# a(2, 4)  = 6   #  2  * 3    * 6^3       = 6^4
# a(3, 4)  = 8   #  3  * 6^3  * 8^3       = 24^4
# a(4, 4)  = 8   #  4  * 8^2              = 4^4
# a(5, 4)  = 10  #  5  * 8^3  * 10^3      = 40^4
# a(6, 4)  = 12  #  6  * 8^3  * 12^3      = 48^4
# a(7, 4)  = 14  #  7  * 8^3  * 14^3      = 56^4
# a(8, 4)  = 15  #  8  * 10^3 * 12^3 * 15 = 120^4
# a(9, 4)  = 12  #  9  * 12^2             = 6^4
# a(10, 4) = 18  #  10 * 12^3 * 15^3 * 18 = 180^4
# a(11, 4) =
# a(12, 4) = 20  #  12 * 15^3 * 20        = 30^4
# a(13, 4) =
# a(14, 4) =
# a(15, 4) = 24  #  15 * 18^3 * 20^3 * 24 = 360^4
# a(16, 4) = 16  #  16                    = 2^4
# a(17, 4) =
# a(18, 4) = 27  #  18 * 24   * 27^3      = 54^4
# a(19, 4) =
# a(20, 4) = 30  #  20 * 24   * 30^3      = 60^4


# 3 -> (8^3)
# 4 -> (8^2)

# 6 -> (12^3)
# 9 -> (12^2)
