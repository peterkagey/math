
# ? a(n + k) < a(n - k) for all k <= a(n)
# ? a(n + k) > a(n - k) for all k <= a(n)


# -------------------------------

# The lexicographically earliest sequence of positive integers such that a(1) = a(2) = 1 and a(n + k) != a(n - k) for all k <= a(n).

class AlecsAirportSequence

  def initialize
    @known_sequence = [1, 1]
    @disallowed_values = [[], [], [1]]
    compute
  end

  def compute
    (2..1000).each do |n|
      a_n = (1..Float::INFINITY).find { |i| !@disallowed_values[n].include?(i) }
      @known_sequence << a_n
      (1..a_n).each do |k|
        @disallowed_values[n + k] ||= []
        @disallowed_values[n + k] << @known_sequence[n - k]
      end
    end

    p @known_sequence.join(", ")
  end

end

# AlecsAirportSequence.new


# The lexicographically earliest sequence such that:
# a(0) = 1
# a(n + k) != a(n - k) for all a(n) <= k < n
class AlecsAirportSequence2

  def initialize
    @known_sequence = [1]
    @disallowed_values = [[], []]
    compute
  end

  def compute
    (1..1000).each do |n|
      @disallowed_values[n] ||= []
      a_n = (1..Float::INFINITY).find { |i| !@disallowed_values[n].include?(i) }
      @known_sequence << a_n
      (a_n..n).each do |k|
        @disallowed_values[n + k] ||= []
        @disallowed_values[n + k] << @known_sequence[n - k]
      end
    end

    p @known_sequence.join(", ")[0...260]
  end

end

# AlecsAirportSequence2.new



#
# a(n + k * a(n)) != a(n - k) for all k <= n
#

# Lexicographically earliest sequence such that a(0) = 1 and a(n + k) != a(n - k) for all 0 < k <= floor(n/a(n))
class AlecsAirportSequence3

  def initialize
    @known_sequence = [1]
    @disallowed_values = [[], []]
    print @known_sequence.join(", ") + ", "
    compute
  end

  def compute
    (1..Float::INFINITY).each do |n|
      @disallowed_values[n] ||= []
      a_n = (1..Float::INFINITY).find { |i| !@disallowed_values[n].include?(i) }
      @known_sequence << a_n
      (0..n/a_n).each do |k|
        @disallowed_values[n + k] ||= []
        @disallowed_values[n + k] << @known_sequence[n - k]
      end
      print "#{a_n}, "
    end
    puts ""
  end

end

# AlecsAirportSequence3.new

# Lexicographically earliest sequence such that a(0) = 1 and a(n + k) != a(n - k) for all 0 < k <= ceil(n/a(n))
class AlecsAirportSequence4

  def initialize
    @known_sequence = [1]
    @disallowed_values = [[], []]
    print @known_sequence.join(", ") + ", "
    compute
  end

  def compute
    (1..Float::INFINITY).each do |n|
      @disallowed_values[n] ||= []
      a_n = (1..Float::INFINITY).find { |i| !@disallowed_values[n].include?(i) }
      @known_sequence << a_n
      (0..(n/a_n.to_f).ceil).each do |k|
        @disallowed_values[n + k] ||= []
        @disallowed_values[n + k] << @known_sequence[n - k]
      end
      print "#{a_n}, "
    end
    puts ""
  end

end

# AlecsAirportSequence4.new

# --------------------------------------------------------------------
# NJA Sloane's suggestion:
# a(n + k) != 2 * a(n) - a(n - k), and no repeating terms
# This (appears to) result in A133256.
class AlecsAirportSequence5

  def initialize
    @known_sequence = [1]
    @disallowed_values = [[]]
    print @known_sequence.join(", ") + ", "
    compute
  end

  def compute
    (1..60).each do |n|
      @disallowed_values[n] ||= []
      a_n = (1..Float::INFINITY).find { |i| !@disallowed_values[n].include?(i) && !@known_sequence.include?(i)}
      @known_sequence << a_n
      (0..n).each do |k|
        @disallowed_values[n + k] ||= []
        @disallowed_values[n + k] << 2 * a_n - @known_sequence[n - k]
      end
      print "#{a_n}, "
    end
    puts ""
  end

end

# AlecsAirportSequence5.new

# --------------------------------------------------------------------
# NJA Sloane's suggestion:
# a(n + k) != 2 * a(n) - a(n - k) (without the constraint of no repeating terms)
# A229037
class AlecsAirportSequence6

  def initialize
    @known_sequence = [1]
    @disallowed_values = [[]]
    print @known_sequence.join(", ") + ", "
    compute
  end

  def compute
    (1..60).each do |n|
      @disallowed_values[n] ||= []
      a_n = (1..Float::INFINITY).find { |i| !@disallowed_values[n].include?(i) }
      @known_sequence << a_n
      (0..n).each do |k|
        @disallowed_values[n + k] ||= []
        @disallowed_values[n + k] << 2 * a_n - @known_sequence[n - k]
      end
      print "#{a_n}, "
    end
    puts ""
  end

end

AlecsAirportSequence6.new
puts "\n"
# --------------------------------------------------------------------
# NJA Sloane's suggestion:
# a(n + k) != 2 * a(n) - a(n - k)
#   # without the constraint of no repeating terms
#   # with the constraint that k < n/k
class AlecsAirportSequence7

  def initialize
    @known_sequence = [1]
    @disallowed_values = [[]]
    print @known_sequence.join(", ") + ", "
    compute
  end

  def compute
    (1..60).each do |n|
      @disallowed_values[n] ||= []
      a_n = (1..Float::INFINITY).find { |i| !@disallowed_values[n].include?(i) }
      @known_sequence << a_n
      (1..n/a_n).each do |k|
        @disallowed_values[n + k] ||= []
        @disallowed_values[n + k] << 2 * a_n - @known_sequence[n - k]
      end
      print "#{a_n}, "
    end
    puts ""
  end

end

# AlecsAirportSequence7.new

# --------------------------------------------------------------------
# NJA Sloane's suggestion:
# a(n + k) != 2 * a(n) - a(n - k)
#  - with no repeated terms
#  - with the constraint that k <= ceiling(n/a_n)
class AlecsAirportSequence8

  def initialize
    @known_sequence = [1]
    @disallowed_values = [[]]
    print @known_sequence.join(", ") + ", "
    compute
  end

  def compute
    (1..60).each do |n|
      @disallowed_values[n] ||= []
      a_n = (1..Float::INFINITY).find { |i| !@disallowed_values[n].include?(i) }
      @known_sequence << a_n
      (1..(n/a_n.to_f).ceil).each do |k|
        @disallowed_values[n + k] ||= []
        @disallowed_values[n + k] << 2 * a_n - @known_sequence[n - k]
      end
      print "#{a_n}, "
    end
    puts ""
  end

end

AlecsAirportSequence8.new
