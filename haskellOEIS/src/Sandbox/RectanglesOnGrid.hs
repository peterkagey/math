module Sandbox.RectanglesOnGrid where
import Data.List (permutations, subsequences, nub)
import Helpers.Table (tableByAntidiagonals, triangleByRows, indicesByAntidiagonals, triangularize, antidiagonalize)
-- A085582 (more generally, A289832)
-- 0, 1, 10, 44, 130, 313, 640, 1192, 2044, 3305, 5078, 7524, 10750, 14993, 20388, 27128, 35448, 45665, 57922, 72636, 89970, 110297, 133976, 161440, 192860, 228857, 269758, 316012, 367974, 426417, 491468, 564120, 644640, 733633, 831674, 939292
a289832 0 _ = 0
a289832 _ 0 = 0
a289832 n 1 = n * (n + 1) `div` 2
a289832 1 k = a289832 k 1
a289832 n k = (2 * a289832 n (k - 1)) - a289832 n (k - 2) + maxSize where
  maxSize = sum $ map weighted [1..n] where
    weighted i = (n - i + 1) * f i k

f n k
  | n == k    = n + 2 * length diagonals
  | otherwise = 1 + 2 * length diagonals' where
    diagonals = [a | a <- [1..n], n `mod` a == 0, n `div` a >= 3]
    diagonals' = filter isValid [(a, b) | a <- [1..n], b <- [1..k]] where
      isValid (a, b) = isCongruent && a' >= 2 && a' == b' where
        isCongruent = (n - b) `mod` a == 0 && (k - a) `mod` b == 0
        a' = (n - b) `div` a
        b' = (k - a) `div` b

-- n\k| 1  2  3  4  5   6   7   8   9  10  11  12
-- ---+----------------------------------------------
--  1 | 1  .  .  .  .   .   .   .   .   .   .   .
--  2 | 1  2  .  .  .   .   .   .   .   .   .   .
--  3 | 1  1  5  .  .   .   .   .   .   .   .   .
--  4 | 1  1  1  6  .   .   .   .   .   .   .   .
--  5 | 1  1  1  3  9   .   .   .   .   .   .   .
--  6 | 1  1  1  1  1  10   .   .   .   .   .   .
--  7 | 1  1  1  1  5   1  13   .   .   .   .   .
--  8 | 1  1  1  1  1   1   5  14   .   .   .   .
--  9 | 1  1  1  1  1   5   1   1  17   .   .   .
-- 10 | 1  1  1  1  1   3   1   3   1  18   .   .
-- 11 | 1  1  1  1  1   1   5   1   5   5  21   .
-- 12 | 1  1  1  1  1   1   1   1   5   1   1  22
