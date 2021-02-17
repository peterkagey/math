require 'set'

# set = (0...3*n).to_a
#
#
# def lexicographically_before(xs, ys)
#   xs.empty? && ys.empty?
#
#   xs.zip(ys).all? { |x, y| y.nil? ? false : x.nil? || x <= y }
# end
#
# x3s.flat_map do |a|
#   x3s.flat_map do |b|
#     x3s.map do |c|
#       [a, b, c]
#       statistics = [
#          a.length,
#          b.length,
#          c.length,
#          (a & b).length,
#          (a & c).length,
#          (b & c).length,
#          (a & b & c).length
#        ]
#       p [a, b, c] unless s.include?(statistics)
#       s << statistics
#     end
#   end
# end
#
# p s, s.size

# def a(n)
#   s = Set.new
#   (0..0).flat_map do |abc|
#     (0..n-abc).flat_map do |ab|
#       (0..n-abc).flat_map do |ac|
#         (0..n-abc).flat_map do |bc|
#           (0..n-abc-ab-ac).flat_map do |a|
#             (0..n-abc-ab-bc).flat_map do |b|
#               (0..n-abc-ac-bc).flat_map do |c|
#                 x = [
#                   a + ab + ac + abc,
#                   b + ab + bc + abc,
#                   c + ac + bc + abc,
#                   ab + abc,
#                   ac + abc,
#                   bc + abc,
#                   abc
#                 ]
#                 s << x if (a + ab + ac + abc == n) && (b + ab + bc + abc == n) && (c + ac + bc + abc == n)
#               end
#             end
#           end
#         end
#       end
#     end
#   end
#   p s
#   s.size
# end
# (0..100).each { |i| puts "#{i} #{a(i)}" }

# n a(n)
# 0 1
# 1 15
# 2 100
# 3 436
# 4 1459
# 5 4069
# 6 9929
# 7 21871
# 8 44426
# 9 84494
# 10 152171
# 11 261749
# 12 432906
# 13 692102
# 14 1074198
# 15 1624314
# 16 2399943
# 17 3473337
# 18 4934182
# 19 6892578
# 20 9482341
# 21 12864643

#
# The triple (A, B, C) = ({1, 2}, {1, 2, 3}, {1, 4}) is equivalent to the triple (A', B', C') = ({1, 8}, {1, 4, 8}, {5, 8}) because:
# |A|         = |{1, 2}|    = 2 = |{1, 8}|    = |A'|
# |B|         = |{1, 2, 3}| = 3 = |{1, 4, 8}| = |B'|
# |C|         = |{1, 4}|    = 2 = |{5, 8}|    = |C'|
# |A & B|     = |{1, 2}|    = 2 = |{1, 8}|    = |A' & B'|
# |A & C|     = |{1}|       = 1 = |{8}|       = |A' & C'|
# |B & C|     = |{1}|       = 1 = |{8}|       = |B' & C'|
# |A & B & C| = |{1}|       = 1 = |{8}|       = |A' & B' & C'|
