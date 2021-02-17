class NSequences # Non-self-repeating sequences

  def initialize(digits = 8, base = 4)
    @d = digits - 2
    @b = base
  end

  def all_base_b_strings
    p "b"
    (0...@b**@d).map { |i| '0' + i.to_s(@b).rjust(@d, '0') + '0' }
  end

  def all_non_repeating_strings
    p "non_repeat"
    all_base_b_strings.select do |s|
      (s =~ /(\d)\1\1/).nil? && (s =~ /(\d\d).*\1/).nil?
    end
  end

  def arrays
    p "arrays"
    all_non_repeating_strings.map { |s| s.split('').map(&:to_i).map(&:next) }
  end

  def print
    min_sum = 10000
    count = 0
    arrays.each do |ary|
      sum = ary.reduce(:+)
      if sum <= min_sum
        min_sum = sum
        p ary.to_s + " -> " + sum.to_s
        count += 1
      end
    end
    puts count
  end

end

NSequences.new(13, 5).print
