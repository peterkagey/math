module Sandbox.RedAndBlueDice where
import Data.List (permutations, tails)
import Helpers.Records (allMax, allMin, countMax, countMin, maxIndices)
-- https://math.stackexchange.com/questions/3035452/error-in-solution-of-peter-winkler-red-and-blue-dice-puzzle
-- On permutations

equalSumRootedStrings :: [Int] -> [Int] -> Int
equalSumRootedStrings [] _ = 0
equalSumRootedStrings _ [] = 0
equalSumRootedStrings (x:xs) (y:ys) = recurse xs ys x y 0 where
  recurse [] [] sumA sumB c
    | sumA == sumB = c + 1
    | otherwise    = c
  recurse (a:as) [] sumA sumB c
    | sumA < sumB = recurse as [] (a + sumA) sumB c
    | sumA == sumB = c + 1
    | sumA > sumB = c
  recurse [] (b:bs) sumA sumB c
    | sumA < sumB = c
    | sumA == sumB = c + 1
    | sumA > sumB = recurse [] bs sumA (b + sumB) c
  recurse (a:as) (b:bs) sumA sumB c
    | sumA == sumB = recurse as (b:bs) (a + sumA) sumB (c + 1)
    | sumA < sumB = recurse as (b:bs) (a + sumA) sumB c
    | sumA > sumB = recurse (a:as) bs sumA (b + sumB) c

equalSumSubstrings :: [Int] -> [Int] -> Int
equalSumSubstrings s1 s2 = sum [equalSumRootedStrings a b | a <- tails s1, b <- tails s2]

permutationPairs n = [equalSumSubstrings a b | a <- permutations [1..n], b <- permutations [1..n]]

-- Fewest number of nonempty substrings in a, b in S_n with equal sums.
-- 1,3,6,8,11,15

-- Greatest number of nonempty substrings in a, b in S_n with equal sums.
-- 1,3,8,16,27

-- Pairs (a, b) \in S_n \times S_n such that the number of nonempty substrings in a and b is maximized.
-- a' n = countMax (\(a, b) -> equalSumSubstrings a b) $ permutationPairs' n
-- 1,4,8,4,8
-- Example for n=5
-- (52143,52143),(52143,34125),(51324,51324),(51324,42315),(34125,52143),(34125,34125),(42315,51324),(42315,42315)
-- How many distinct permutations show up? In this example, just four (of which two are essentially different): 52143, 51324, 42315, 34125

-- Pairs (a, b) \in S_n \times S_n such that the number of nonempty substrings in a and b is minimized.
-- a' n = countMin (\(a, b) -> equalSumSubstrings a b) $ permutationPairs' n
-- 1,4,20,24,48
-- Example for n = 4
-- (3412,4231),(3412,1324),(1432,4213),(1432,3124),(4132,1243),(4132,3421),(2143,4231),(2143,1324),(4213,1432),(4213,2341),(1243,4132),(1243,2314),(2341,4213),(2341,3124),(4231,3412),(4231,2143),(3421,4132),(3421,2314),(1324,3412),(1324,2143),(3124,1432),(3124,2341),(2314,1243),(2314,3421])
-- Twelve distinct permutations: 1243,1324,1432,2143,2314,2341,3124,3412,3421,4231,4213,4132
