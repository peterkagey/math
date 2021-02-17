# No repeated substrings in either orientation; repeated duplicates are okay.
# 1 1 2 3 1
require 'set'
class Braxton2

  def self.pairs(array)
    array[0..-1].zip(array[1..-1])[0...-1]
  end

  def self.contains_no_repeated_substring(array)
    s = SortedSet.new
    pairs(array).all? { |pair| s.include?(pair) ? false : s << pair } &&
    pairs(array.reverse).all? { |pair| s.include?(pair) ? false : s << pair }
  end

end

# x = 9
# n = 5

# p (0...n**x)
#     .map { |i| i.to_s(n).rjust(x, "0").split("") }
#     .select { |ary| Braxton2.contains_no_repeated_substring(ary) }
#     .map { |ary| ary.map(&:to_i) }
#     .min_by { |ary| ary.reduce(:+) }

# [0, 1]
# [0, 1, 2]
# [0, 1, 2, 0]
# [0, 1, 2, 0, 3]
# [0, 1, 2, 0, 3, 1]
# [0, 1, 2, 0, 3, 4, 0]
# [0, 1, 2, 0, 3, 1, 4, 0]
