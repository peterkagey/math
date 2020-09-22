require_relative '../helpers/haskell_comparison'

SKIPPING = [
  "000052", # 1-digit numbers arranged in alphabetical order, then the 2-digit numbers arranged in alphabetical order, then the 3-digit numbers, etc.
  "031435", # Reversal point for powers of consecutive natural numbers.
  "054519", # Number of increasing arithmetic progressions of nonnegative integers ending in n, including those of length 1 or 2.
  "059905", # Index of first half of decomposition of integers into pairs based on A000695.
  "060874", # Intrinsic 4-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "060875", # Intrinsic 5-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "060876", # Intrinsic 6-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "060877", # Intrinsic 7-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "060878", # Intrinsic 8-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "060879", # Intrinsic 9-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "060947", # Intrinsic 10-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "060948", # Intrinsic 11-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "060949", # Intrinsic 12-palindromes: n is an intrinsic k-palindrome if it is a k-digit palindrome in some base.
  "082461", # Generalized Smarandache palindromes which are not palindromes: a generalized Smarandache palindrome (GSP) is a number of the form a1a2...anan...a2a1 or a1a2...an-1anan-1...a2a1, where all a1, a2, ..., an are positive integers of various number of digits.
  "082647", # Number of ways n can be expressed as the sum of d consecutive positive integers (where d>0 is a divisor of n)
  "098164", # Smallest available number fitting the infinite repeating pattern of digits even/even/odd/odd/even/even/odd/odd/...
  "109451", #  a(1)=1; a(n) = smallest positive integer not already present such that a(n-1) and a(n) have a different number of 1's in their binary expansions.
  "121341", # Number of decimal places before 1/n either recurs or terminates.
  "143051", # Smallest number not occurring earlier and smaller than the largest square so far, the next square if no such number exists.
  "163325", # Pick digits at the even distance from the least significant end of the ternary expansion of n, then convert back to decimal.
  "165513", # Trapezoidal numbers.
  "173902", # Numbers n with property that the cube of each digit of n is a substring of n^3.
  "216256", # Minimum length of a longest unimodal subsequence of a permutation of n elements.
  "217489", # Least positive integer without a digit 1, not listed earlier and not divisible by any digit of the preceding term.
  "258448", # a(5) = 0; a(n) = 1 + min{a(k + m): n = k * m}.
  "262159", # a(1) = 1, for n > 1 the least composite number k > a(n-1) such that a(n-1) + k is also a composite number.",
  "262436", # Number of ways to represent 2n - 1 as p^2 + q^2 + r with p, q, and r prime, and p >= q.
  "999995", # Unpublished

  # A071068
  "071068", # Number of ways to write n as a sum of two unordered squarefree numbers.
  "262351", # Sum of the parts in the partitions of n into exactly two squarefree parts.

  # A080715
  "080715", # Numbers n such that for any positive integers (a, b), if a * b = n then a + b is prime.
  "268403", # Partial sums of A080715.
]

PENDING_HASKELL = {
  # Other
  "260896" => "A260896 a(n) counts the number of integers m such that there exist k and h with 2n^2 < mk^2 < 2(n+1)^2 and 2n^2 < 2mh^2 < 2(n+1)^2.",
  "272573" => "A272573 Start a spiral of numbers on a hexagonal tiling, with the initial hexagon as a(1) = 1. a(n) is the smallest positive integer not equal to or previously adjacent to its neighbors.",
}

PENDING_RUBY = {
  "000010" => "Euler's phi function.",
  "000037" => "Numbers that are not squares (or, the nonsquares).",
  "000040" => "Prime numbers.",
  "000194" => "n appears 2n times; also nearest integer to square root of n.",
  "000720" => "pi(n), the number of primes <= n.",
  "001414" => "Integer log of n: sum of primes dividing n (with repetition).",
  "001511" => "The ruler function: 2^a(n) divides 2n",
  "002262" => "Triangle read by rows: T(n,k), 0 <= k <= n, in which row n lists the first n+1 nonnegative integers.",
  "002808" => "Composite numbers",
  "006519" => "Highest power of 2 dividing n.",
  "006530" => "Gpf(n): greatest prime dividing n; a(1)=1. ",
  "007318" => "Pascal's triangle read by rows: C(n,k) = binomial(n,k) = n!/(k!*(n-k)!), 0 <= k <= n.",
  "007814" => "The 2-adic valuation of n",

  "025581" => "Triangle T(n, k) = n-k, 0 <= k <= n.",
  "027746" => "Triangle in which first row is 1, n-th row (n>1) gives prime factors of n with repetition.",
  "035516" => "Triangular array formed from Zeckendorf expansion of integers: repeatedly subtract the largest Fibonacci number you can until nothing remains.",

  "066099" => "Triangle read by rows, in which row n lists the compositions of n in reverse lexicographic order.",
  "092487" => "A006255(n) - n",
  "112798" => "Table where n-th row is factorization of n, with each prime p_i replaced by i.",
  "185869" => "(Odd,even)-polka dot array in the natural number array A000027; read by antidiagonals.",
  "228351" => "Triangle read by rows in which row n lists the compositions (ordered partitions) of n",
  "228369" => "Triangle read by rows in which row n lists the compositions (ordered partitions) of n in lexicographic order.",
  "238689" => "Table read by rows: first row is {1}; for n >1, T(n, k) is the k-th largest prime factor of n (repeated prime factors are counted repeatedly).",
  "240024" => "Composite EKG",
  "265400" => "a(n) = one-based index to the nearest horizontally or vertically adjacent inner neighbor in square-grid spirals, or 0 if n is one of the corner cases A033638.",

  "273156" => "Product of all parts in Zeckendorf representation of n. ",
  "273185" => "Start with a(0) = 0. Thereafter a(n) is the number of m < n with the property that a(m) + n is a perfect square.",
  "273190" => "a(0) = 0; thereafter a(n) is the number of m < n for which m + n is a perfect square.",
  "273191" => "a(n) is the length of the n-th run of A273190.",
  "273620" => "Table read by antidiagonals: T(n, k) = floor(sqrt(k) * floor(n/sqrt(k) + 1)) with n >= 1, k >= 1.",
  "273823" => "Table read by rows: the n-th row is the list of numbers to the left of n in the natural numbers read by antidiagonals.",
  "273824" => "Table read by rows: the n-th row is the list of numbers above n in the table natural numbers read by antidiagonals.",
  "273825" => "Table read by rows: the n-th row is the list of numbers diagonally up and to the left of n in the natural numbers read by antidiagonals.",
  "274079" => "Table read by rows: the n-th row is the list of numbers diagonally up and to the right of n in the natural numbers read by antidiagonals.",
  "274080" => "Table read by rows: row n gives all numbers in the same row, column, or diagonal as n in the table natural numbers read by antidiagonals.",
  "274701" => "First differences of A259280",
  "275673" => "List of numbers that are in a spoke of a hexagonal spiral.",
  "276117" => "A064664(A000040(n)) - A064664(A006093(n))",
  "276162" => "Square array read by antidiagonals: T(n,k) = Product_{i = 1..k} (GCD(n, i)).",
  "276163" => "a(n) is the maximum first-player score difference of a \"Coins in a Row\" game over all permutations of coins 1..n with both players using a minimax strategy.",
  "276164" => "a(n) is the maximum first-player score of a \"Coins in a Row\" game over all permutations of coins 1..n with both players using a minimax strategy.",
  "276165" => "a(n) is the first-player score difference of a \"Coins in a Row\" game over the nth row of A066099 using a minimax strategy.",
  "276166" => "a(n) is the first player's score in a \"Coins in a Row\" game over the nth row of A066099 using a minimax strategy.",
  "276167" => "a(n) is the second player's score in a \"Coins in a Row\" game over the nth row of A066099 using a minimax strategy.",
  "276374" => "Numbers n such that A240024(n) = A002808(n)",
  "276375" => "Numbers n such that A240024(n + 1) = A002808(n)",
  "276127" => "a(1) = 1; a(n) = A001414(A064413(n)) for n > 1.",
  "277278" => "a(n) = smallest m for which there is a sequence n = b_1 < b_2 < ... < b_t = m such that b_1 + b_2 +...+ b_t is a perfect square.",
  "277494" => "a(n) = smallest m for which there is a sequence n = b_1 < b_2 <= b_3 <= ... <= b_t = m such that b_1*b_2*...*b_t is a perfect cube.",
  "277516" => "a(n) = smallest k >= 0 for which there is a sequence n = b_1 < b_2 < ... < b_t = n + k such that b_1 + b_2 +...+ b_t is a perfect square.",
}

describe "Haskell files" do
  HaskellComparer.ruby_scripts.sort.each do |sequence_name|
    it "should include a script for A#{sequence_name}" do
     next if SKIPPING.include?(sequence_name)
     pending PENDING_HASKELL[sequence_name] if PENDING_HASKELL[sequence_name]
      included = HaskellComparer.haskell_scripts.include?(sequence_name)
      expect(included).to eq true
    end
  end
end

describe "Ruby files" do
  HaskellComparer.haskell_scripts.sort.each do |sequence_name|
    it "should include a script for A#{sequence_name}" do
     pending PENDING_RUBY[sequence_name] if PENDING_RUBY[sequence_name]
      included = HaskellComparer.ruby_scripts.include?(sequence_name)
      expect(included).to eq true
    end
  end
end
