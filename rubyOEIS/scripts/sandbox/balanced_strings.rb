# The number of length 2n + 1 strings over a {0, 1} alphabet such that the first half of any initial odd substring is a permutation of the second half.
#
# Equivalence classes up to swapping the letters of the alphabet.
#
# 1             -> 1       is a permutation of 1
# 101           -> 10      is a permutation of 01
# 10101         -> 101     is a permutation of 101
# 1010110       -> 1010    is a permutation of 0110
# 101011010     -> 10101   is a permutation of 11010
# 10101101011   -> 101011  is a permutation of 101011
# 1010110101101 -> 1010110 is a permutation of 0101101

def next_generation(string)
  return "String length must be odd!" if string.length.even?
  return "String length must be >= 3!" if string.length < 3
  middle_value = string.length / 2 + 1
  prefix = string[0...middle_value]
  known_suffix = string[middle_value + 1..-1]
  new_characters = known_suffix
    .split("")
    .reduce(prefix) { |accum, c| accum.sub(c, "") }
  [new_characters, new_characters.reverse].uniq.map { |x| string + x }
end

def a(n)
  return ["1"].length if n == 0
  (1...n)
    .reduce(["101", "111"]) { |accum, _| accum.flat_map { |a| next_generation(a) } }
end

# 1, 2, 3, 4, 7, 11, 17, 25, 49, 75, 129, 191, 329, 489, 825, 1237, 2473, 3737, 6329, 9435, 16833, 25081, 41449, 61043, 115409, 172441, 290617
