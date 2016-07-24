require_relative '../helpers/haskell_comparison'

SKIPPING = [
  "A000052", # 1-digit numbers arranged in alphabetical order, then the 2-digit numbers arranged in alphabetical order, then the 3-digit numbers, etc.
  "A031435", # Reversal point for powers of consecutive natural numbers.
  "A054519", # Number of increasing arithmetic progressions of nonnegative integers ending in n, including those of length 1 or 2.
  "A059905", # Index of first half of decomposition of integers into pairs based on A000695.
  "A060874", # Intrinsic 4-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "A060875", # Intrinsic 5-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "A060876", # Intrinsic 6-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "A060877", # Intrinsic 7-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "A060878", # Intrinsic 8-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "A060879", # Intrinsic 9-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "A060947", # Intrinsic 10-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "A060948", # Intrinsic 11-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "A060949", # Intrinsic 12-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "A082461", # Generalized Smarandache palindromes which are not palindromes: a generalized Smarandache palindrome (GSP) is a number of the form a1a2...anan...a2a1 or a1a2...an-1anan-1...a2a1, where all a1, a2, ..., an are positive integers of various number of digits.
  "A082647", # Number of ways n can be expressed as the sum of d consecutive positive integers (where d>0 is a divisor of n)
  "A098164", # Smallest available number fitting the infinite repeating pattern of digits even/even/odd/odd/even/even/odd/odd/...
  "A109451", #  a(1)=1; a(n) = smallest positive integer not already present such that a(n-1) and a(n) have a different number of 1's in their binary expansions.
  "A121341", # Number of decimal places before 1/n either recurs or terminates.
  "A143051", # Smallest number not occurring earlier and smaller than the largest square so far, the next square if no such number exists.
  "A163325", # Pick digits at the even distance from the least significant end of the ternary expansion of n, then convert back to decimal.
  "A165513", # Trapezoidal numbers.
  "A173902", # Numbers n with property that the cube of each digit of n is a substring of n^3.
  "A216256", # Minimum length of a longest unimodal subsequence of a permutation of n elements.
  "A217489", # Least positive integer without a digit 1, not listed earlier and not divisible by any digit of the preceding term.
  "A258448", # a(5) = 0; a(n) = 1 + min{a(k + m): n = k * m}.
  "A262159", # a(1) = 1, for n > 1 the least composite number k > a(n-1) such that a(n-1) + k is also a composite number.",
  "A262436", # Number of ways to represent 2n - 1 as p^2 + q^2 + r with p, q, and r prime, and p >= q.
  "A999995", # Unpublished

  # A071068
  "A071068", # Number of ways to write n as a sum of two unordered squarefree numbers.
  "A262351", # Sum of the parts in the partitions of n into exactly two squarefree parts.

  # A080715
  "A080715", # Numbers n such that for any positive integers (a, b), if a * b = n then a + b is prime.
  "A268403", # Partial sums of A080715.
]

PENDING_HASKELL = {
  # Graham
  "A006255" => "A006255 Ron Graham's sequence: a(n) = smallest m for which there is a sequence n = b_1 < b_2 < ... < b_t = m such that b_1*b_2*...*b_t is a perfect square.",
  "A067565" => "A067565 Inverse of Ron Graham's sequence (A006255), or zero if and only if n is a prime.",
  "A233421" => "A233421 Let m = n-th nonsquare = A000037(n); then a(n) = A006255(m).",
  "A255167" => "A255167 a(n) = A072905(n) - A006255(n).",
  "A255363" => "A255363 Numbers with the property that A006255(k) = A070229(k).",
  "A255980" => "A255980 Number of iterations of A067565 required to reach a perfect square.",
  "A259527" => "A259527 a(n) counts the number of sequences n = b_1 < b_2 < ... < b_t = A006255(n) such that b_1*b_2*...*b_t is a perfect square.",
  "A260510" => "A260510 a(n) = log_2(A259527(n)).",
  "A269045" => "A269045 Indices k such that A006255(k) != A070229(k); that is, the kth term of Ron Graham's sequence is not equal to k + lpf(k).",

  # Square spiral
  "A260643" => "A260643 Start a spiral of numbers on a square grid, with the initial square as a(1) = 1. a(n) is the smallest positive integer not equal to or previously adjacent (horizontally/vertically) to its neighbors. See the Comments section for a more exact definition.",
  "A265414" => "A265414 a(n) = point where A260643 for the first time obtains value n.",
  "A265415" => "A265415 Positions of ones in A260643.",
  "A265579" => "A265579 a(n) = A260643(n) - 1.",

  # Other
  "A260896" => "A260896 a(n) counts the number of integers m such that there exist k and h with 2n^2 < mk^2 < 2(n+1)^2 and 2n^2 < 2mh^2 < 2(n+1)^2.",
  "A272573" => "A272573 Start a spiral of numbers on a hexagonal tiling, with the initial hexagon as a(1) = 1. a(n) is the smallest positive integer not equal to or previously adjacent to its neighbors.",
}

PENDING_RUBY = {
  "A000010" => "Euler's phi function.",
  "A000040" => "Prime numbers.",
  "A000194" => "n appears 2n times; also nearest integer to square root of n.",
  "A002262" => "Triangle read by rows: T(n,k), 0 <= k <= n, in which row n lists the first n+1 nonnegative integers.",
  "A006530" => "Gpf(n): greatest prime dividing n; a(1)=1. ",
  "A007318" => "Pascal's triangle read by rows: C(n,k) = binomial(n,k) = n!/(k!*(n-k)!), 0 <= k <= n.",
  "A025581" => "Triangle T(n, k) = n-k, 0 <= k <= n.",
  "A035516" => "Triangular array formed from Zeckendorf expansion of integers: repeatedly subtract the largest Fibonacci number you can until nothing remains.",
  "A273156" => "Product of all parts in Zeckendorf representation of n. ",
  "A273185" => "Start with a(0) = 0. Thereafter a(n) is the number of m < n with the property that a(m) + n is a perfect square.",
  "A273190" => "a(0) = 0; thereafter a(n) is the number of m < n for which m + n is a perfect square.",
  "A273191" => "a(n) is the length of the n-th run of A273190.",
  "A273620" => "Table read by antidiagonals: T(n, k) = floor(sqrt(k) * floor(n/sqrt(k) + 1)) with n >= 1, k >= 1.",

  # A269526: Diagonals of array in which each term is the least positive value satisfying the condition that no row, column, or diagonal contains a repeated term.
  "A273823" => "Table read by rows: the n-th row is the list of numbers to the left of n in the natural numbers read by antidiagonals.",
  "A273824" => "Table read by rows: the n-th row is the list of numbers above n in the table natural numbers read by antidiagonals.",
  "A273825" => "Table read by rows: the n-th row is the list of numbers diagonally up and to the left of n in the natural numbers read by antidiagonals.",
  "A274079" => "Table read by rows: the n-th row is the list of numbers diagonally up and to the right of n in the natural numbers read by antidiagonals.",
  "A274080" => "Table read by rows: row n gives all numbers in the same row, column, or diagonal as n in the table natural numbers read by antidiagonals.",
}

describe "Haskell files" do
  HaskellComparer.ruby_scripts.sort.each do |sequence_name|
    it "should include a script for #{sequence_name}" do
      next if SKIPPING.include?(sequence_name)
      pending PENDING_HASKELL[sequence_name] if PENDING_HASKELL[sequence_name]
      included = HaskellComparer.haskell_scripts.include?(sequence_name)
      expect(included).to eq true
    end
  end
end

describe "Ruby files" do
  HaskellComparer.haskell_scripts.sort.each do |sequence_name|
    it "should include a script for #{sequence_name}" do
      pending PENDING_RUBY[sequence_name] if PENDING_RUBY[sequence_name]
      included = HaskellComparer.ruby_scripts.include?(sequence_name)
      expect(included).to eq true
    end
  end
end
