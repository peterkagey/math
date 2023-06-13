import Data.List (subsequences)
import Helpers.ListHelpers (cartesianProduct)
import Math.NumberTheory.Roots (isKthPower)
import Helpers.Table (tableByAntidiagonals)

baseSequences n = map (n:) $ subsequences [n+1..]

-- This is probably not a very good way of doing this.
allPowers b baseSequence = map (zipWith (^) baseSequence) possiblePowers where
  possiblePowers = cartesianProduct (length baseSequence) [1..b-1]

isValidBaseSequence b baseSequence = any (isKthPower b) $ map product $ allPowers b baseSequence

-- n\k
--------------------------------------------------
-- n\k| 0  1  2  3  4   5   6   7   8   9  10
-- ---+--------------------------------------
--  1 | 0, 1, 2, 3, 4,  5,  6,  7,  8,  9, 10
--  2 | 0, 1, 6, 8, 4, 10, 12, 14, 15,  9, 18
--  3 | 0, 1, 4, 6, 9, 10, 12, 14,  8, 16, 15
--  4 | 0, 1, 4, 6, 4, 10,  9, 14, 15,  9, 18
--  5 | 0, 1, 4, 6, 8, 10,  9, 14, 12, 15, 16
--  6 | 0, 1, 4, 6, 4, 10, 12, 14,  8,  9, 15
--  7 | 0, 1, 4, 6, 8, 10,  9, 14, 12, 15, 16
--  8 | 0, 1, 4, 6, 4, 10,  9, 14, 12,  9, 16

aT 1 k = k
aT n k = last $ head $ filter (isValidBaseSequence n) $ baseSequences k

a n = case tableByAntidiagonals n of (m,k) -> aT (m + 1) k

-- Table read upward by antidiagonals: T(n,k) is the least m such that there exists a sequence k = b_1 <= b_2 <= ... <= b_t = m such that no term appears n or more times, and the product of the sequence is a power of n.

-- Table read by antidiagonals upward: T(n,k) is the least m > k such that k^x * m^y is a power of n for integers 0 < x,y < n.

baseSequences' k = map (\m -> [k,m]) $ [k+1..]

aT' n k = last $ head $ filter (isValidBaseSequence n) $ baseSequences' k
a' n = case tableByAntidiagonals n of (m,k) -> aT' (m + 2) (k + 1)

-- A343825
--   n\k|    1  2   3   4   5   6   7   8   9   10
-- -----+-----------------------------------------
--    2 |    4, 8, 12,  9, 20, 24, 28, 18, 16,  40
--    3 |    8, 4,  9, 16, 25, 36, 49, 27, 24,  80
--    4 |    4, 4,  9,  8, 20, 24, 28, 18, 12,  40
--    5 |   32, 4,  9,  8, 25, 36, 49, 16, 27, 100
--    6 |    4, 4,  9,  8, 20, 24, 28,  9, 16,  40
--    7 |  128, 4,  9,  8, 25, 36, 49, 16, 27, 100
--    8 |    4, 4,  9,  8, 20, 24, 28, 16, 12,  40
--    9 |    8, 4,  9,  8, 25, 36, 49, 16, 24,  80
--   10 |    4, 4,  9,  8, 20, 24, 28, 16, 16,  40
--   11 | 2048, 4,  9,  8, 25, 36, 49, 16, 27, 100

-- A064549
