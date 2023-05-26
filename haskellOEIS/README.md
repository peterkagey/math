# haskellOEIS
PK's OEIS sequences in Haskell

## In November 2016, I composed a short list of my favorite original sequences:
* [A277781](http://oeis.org/A277781): a(n) is the least k > n such that n\*k or n\*k^2 is a cube.
* [A277494](http://oeis.org/A277494): a(n) = smallest m for which there is a sequence n = b_1 < b_2 ≤ b_3 ≤ ... ≤ b_t = m such that b_1\*b_2\*...\*b_t is a perfect cube.
* [A276164](http://oeis.org/A276164): a(n) is the maximum first-player score of a "Coins in a Row" game over all permutations of coins 1..n with both players using a minimax strategy.
* [A275815](http://oeis.org/A275815): Maximum total number of possible moves that any number of queens of the same color can make on an n X n chessboard.
* [A275288](http://oeis.org/A275288): Least k such that there exists a sequence b_1 < b_2 < ... < b_t = k that includes n and has a reciprocal sum of 1.
* [A272573](http://oeis.org/A272573): Start a spiral of numbers on a hexagonal tiling, with the initial hexagon as a(1) = 1. a(n) is the smallest positive integer not equal to or previously adjacent to its neighbors.
* [A272020](http://oeis.org/A272020): Irregular triangle read by rows: strictly decreasing sequences of positive numbers given in lexicographic order.
* [A269045](http://oeis.org/A269045): Indices k such that A006255(k) != A070229(k); that is, the kth term of Ron Graham's sequence is not equal to k + lpf(k).
* [A261865](http://oeis.org/A261865): a(n) is the least integer k such that some multiple of sqrt(k) falls strictly between n and n+1.
* [A260643](http://oeis.org/A260643): Start a spiral of numbers on a square grid, with the initial square as a(1) = 1. a(n) is the smallest positive integer not equal to or previously adjacent (horizontally/vertically) to its neighbors. (See the Comments section for a more exact definition.)
* [A259527](http://oeis.org/A259527): a(n) counts the number of sequences n = b_1 < b_2 < ... < b_t = A006255(n) such that b_1\*b_2\*...\*b_t is a perfect square.
* [A259280](http://oeis.org/A259280): a(n) is the minimal sum of a positive integer sequence of length n with no duplicate substrings of length greater than 1.
* [A255167](http://oeis.org/A255167): a(n) = A072905(n) - A006255(n). (The gap between A006255(n) and its naïve upper bound.)
* [A254128](http://oeis.org/A254128): Number of binary strings of length n that begin with an odd-length palindrome.
* [A248663](http://oeis.org/A248663): a(1) = 0; a(A000040(n)) = 2^(n-1), and a(n\*m) = a(n) XOR a(m).
* [A248122](http://oeis.org/A248122): Number of strings of length n over a three-letter alphabet that begin with a nontrivial palindrome.


## Two original sequences with the keyword "look"
### A260643
Start a spiral of numbers on a square grid, with the initial square as a(1) = 1. a(n) is the smallest positive integer not equal to or previously adjacent (horizontally/vertically) to its neighbors.

![A269643](https://oeis.org/A260643/graph?png=1)

### A273156
Product of all parts in Zeckendorf representation of n.

![A273156](https://oeis.org/A273156/graph?png=1)

