def all_suffixes(string)
  (1..string.length)
    .map { |i| [string[0...i], string[i..-1]] }
    .select { |initial, _| initial == initial.reverse }
    .map(&:last)
end

def palindrome_count(string)
  (1..string.length).reduce([string]) do |accum, i|
    new_strings = accum.flat_map { |strings| all_suffixes(strings) }
    new_strings.include?("") ? (break i) : new_strings
  end
end
=begin
Cf. A297702
--------------------

A090701(1)  = 1 -> 0
A090701(2)  = 2 -> 01
A090701(3)  = 2 -> 001
A090701(4)  = 2 -> 0001
A090701(5)  = 2 -> 00001
A090701(6)  = 3 -> 001011
A090701(7)  = 3 -> 0001011
A090701(8)  = 4 -> 00101100
A090701(9)  = 4 -> 000101100
A090701(10) = 4 -> 0000101100
A090701(11) = 5 -> 00101100101
A090701(12) = 5 -> 000101100101
A090701(13) = 5 -> 0000101100101
A090701(14) = 6 -> 00101110001011
A090701(15) = 6 -> 000101110001011
A090701(16) = 6 -> 0000101110001011
A090701(17) = 6 -> 00000101110001011
A090701(18) = 7 -> 001011000100101100
A090701(19) = 7 -> 0001001101001110100
A090701(20) = 8 -> 00101100101011001011
--------------------

Least k such that A090701(k) = n
A298474(1) = 1
A298474(2) = 2
A298474(3) = 6
A298474(4) = 8
A298474(5) = 11
A298474(6) = 14
A298474(7) = 18
A298474(8) = 20
-----------------------

A298475(n) is the minimum size of a palindromic partition of the binary representation of n.
  1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 2, 2, 2, 1, 2, 1, 2, 2, 2, 1, 2, 2, 2, 2, 2,
  1, 2, 2, 2, 1, 2, 1, 2, 2, 2, 3, 3, 2, 2, 3, 2, 2, 3, 1, 2, 2, 2, 2, 3, 1, 3,
  2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 1, 2, 2, 2, 3, 3, 2, 2, 1, 2, 3, 2, 2, 3,
  2, 2, 3, 2, 3, 2, 1, 2, 2, 3, 2, 2, 2, 3, 1, 2, 2, 2, 2, 3, 1, 2, ...
-----------------------

Least k such that A298475(k) = n.

A298476(1) = 1      = 0b1
A298476(2) = 2      = 0b10
A298476(3) = 37     = 0b100101
A298476(4) = 203    = 0b11001011
A298476(5) = 1332   = 0b10100110100
A298476(6) = 13428  = 0b11010001110100
A298476(7) = 160884 = 0b100111010001110100
A298476(8) = 858740 = 0b11010001101001110100


The smallest partition of the binary representation of A298476(k) is:
k | A298476(k) | partition
--------------------------
1 | 1          | (1)_2
2 | 2          | (1)(0)_2
3 | 37         | (1001)(0)(1)_2
4 | 203        | (11)(00)(101)(1)_2
5 | 1332       | (101)(00)(1)(101)(00)_2
6 | 13428      | (11)(010)(0)(01110)(1)(00)_2
7 | 160884     | (1001)(1)(101)(000)(111)(010)(0)_2
8 | 858740     | (11)(010)(0)(0110)(1001)(11)(010)(0)_2

floor(log_2(A090701(n))) + 1
--------------------

# Number of length n strings with maximal number of palindromes
b(1) = 2
b(2) = 2
b(3) = 4
b(4) = 12
b(5) = 24
b(6) = 12
b(7) = 28
b(8) = 4
b(9) = 16
b(10) = 60
b(11) = 4
b(12) = 24
b(13) = 140
b(14) = 2
b(15) = 32
b(16) = 230
b(17) = 1112
b(18) = 36
b(19) = 332
b(20) = 4
=end
