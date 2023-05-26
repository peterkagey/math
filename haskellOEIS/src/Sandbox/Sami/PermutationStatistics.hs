import Data.List (findIndices, permutations, sort, splitAt, tails)
import Data.Ratio (Ratio, (%))
import Data.Set (Set)
import qualified Data.Set as Set
import Helpers.CoinsInARow (minimaxDifference)
type Permutation = [Int]

-- descents :: Permutation -> Int
-- descents (a':a:as)
--   | a' > a    = descents (a:as) + 1
--   | otherwise = descents (a:as)
-- descents _ = 0
average :: (Integral a) => [a] -> Rational
average l = fromIntegral (sum l) % fromIntegral (length l)

mDescents :: Int -> Permutation -> Int
mDescents m x = length $ filter (uncurry (>)) $ x `zip` drop m x

-- Number of m-tuples (x_{i} > x_{i + 1} > ... > x_{i + m})
m'Descents :: Int -> Permutation -> Int
m'Descents m x = length $ filter startsWithM'Descent $ take (length x - m + 1) $ tails x where
  startsWithM'Descent p = all (uncurry (>)) $ take (m - 1) $ p `zip` tail p

fixedPoints :: Permutation -> Int
fixedPoints p = length $ filter (uncurry (==)) $ [1..] `zip` p

numberOfCycles :: Permutation -> Int
numberOfCycles = length . cycleSizes

numberOfKCycles :: Int -> Permutation -> Int
numberOfKCycles k p = length $ filter (==k) $ cycleSizes p

largestCycle :: Permutation -> Int
largestCycle = maximum . cycleSizes

shortestCycle :: Permutation -> Int
shortestCycle = minimum . cycleSizes

cycleStructure :: Permutation -> String
cycleStructure p = "(" ++ recurse 1 (Set.fromList [1..length p]) where
  recurse x unseen
    | null unseen       = ")"
    | x `Set.member` unseen = show x ++ recurse (p !! (x - 1)) (Set.delete x unseen)
    | otherwise         = ")(" ++ recurse (minimum unseen) unseen

lengthOfFirstCycle :: Permutation -> Int
lengthOfFirstCycle p = recurse 1 (head p) where
  recurse c 1  = c
  recurse c p' = recurse (c + 1)  (p !! (p' - 1))

cycleSizes :: Permutation -> [Int]
cycleSizes p = sort $ recurse 1 0 [] $ Set.fromList [1..length p] where
  recurse x c sizes unseen
    | null unseen = c : sizes
    | x `Set.member` unseen = recurse (p !! (x - 1)) (c + 1) sizes (Set.delete x unseen)
    | otherwise         = recurse (minimum unseen) 0 (c : sizes) unseen

inversionNumber :: Permutation -> Int
inversionNumber = recurse 0 where
  recurse c []     = c
  recurse c (p:ps) = recurse (c + contribution) ps where
    contribution   = length $ filter (<p) ps

majorIndex :: Permutation -> Int
majorIndex = recurse 1 0 where
  recurse i c (p:p':ps) = recurse (i + 1) (if p > p' then c + i else c) (p':ps)
  recurse i c _         = c

longestIncreasingSubsequence :: Permutation -> Int
longestIncreasingSubsequence = recurse [] where
  recurse l [] = length l
  recurse l ps'@(p:ps)
    | all (<p) l = recurse (p:l) ps
    | otherwise  = recurse (replaceFirst (>p) p l) ps

longestDecreasingSubsequence :: Permutation -> Int
longestDecreasingSubsequence = recurse [] where
  recurse l [] = length l
  recurse l ps'@(p:ps)
    | all (>p) l = recurse (p:l) ps
    | otherwise  = recurse (replaceFirst (<p) p l) ps

-- This fails if there is no element matching the predicate.
replaceFirst :: Show a => (a -> Bool) -> a -> [a] -> [a]
replaceFirst f a as = replaceAt (head $ findIndices f as) a as where
  replaceAt i a as = let (before,after) = splitAt i as in before ++ (a: tail after)

firstStatistic f n = average $ map head $ filter f $ permutations [1..n]

firstLetterKMDescents k m   = firstStatistic ((==k) . mDescents m)       -- X
firstLetterKFixedPoints k   = firstStatistic ((==k) . fixedPoints)       -- Table IV
firstLetterKCycles k        = firstStatistic ((==k) . numberOfCycles)    -- X
firstLetterKCycles' k       = firstStatistic ((==1) . numberOfKCycles k) -- Table III
firstLetterKCycles'' k       = firstStatistic ((==k) . numberOfKCycles 4)
-- firstLetterTwoCycles k      = firstStatistic ((==[k, n-k]) . cycleSizes) -- Table III
firstLetterLargestCycle k   = firstStatistic ((==k) . largestCycle)      -- Table VI
firstLetterLargestCycle' k   = firstStatistic ((<=k) . largestCycle)
firstLetterShortestCycle k  = firstStatistic ((==k) . shortestCycle)     -- Table I
firstLetterShortestCycle' k = firstStatistic ((>=k) . shortestCycle)     -- Table II
firstLetterInversion k      = firstStatistic ((==k) . inversionNumber)   -- Table V
firstLetterMajorIndex k     = firstStatistic ((==k) . majorIndex)

-- firstStatistic ((==9) . minimaxDifference) 9
-- 5377 % 896
-- map (\i -> firstStatistic ((==i) . minimaxDifference) 8) [0,2..16]
-- [1345 % 448,4021 % 1024,39423 % 8720, ..., 9 % 2]
-- map (\i -> firstStatistic ((==i) . minimaxDifference) 7) [-8, -6..4]
-- [5 % 2,3 % 1,663 % 196,325 % 88,2045 % 552,1285 % 304,1187 % 256]
-- map (\i -> firstStatistic ((==i) . minimaxDifference) 6) [1,3..9]
-- [349 % 120,219 % 62,719 % 192,81 % 22,7 % 2]
--map (\i -> firstStatistic ((==i) . minimaxDifference) 5) [-3,-1..5]
-- [2 % 1,21 % 8,131 % 44,17 % 5,27 % 8]
-- map (\i -> firstStatistic ((==i) . minimaxDifference) 4) [0,2,4]
-- [7 % 4,11 % 4,5 % 2]


--VI | Expected value of the first letter of a permutation of S_n that contains an
--VI | (n-k) cycle:
--VI |        0        1        2         3         4
--VI |  1:  1 % 1      .        .         .         .
--VI |  2:  2 % 1    1 / 1      .         .         .
--VI |  3:  5 % 2    2 % 1    1 / 1       .         .
--VI |  4:  3 % 1    5 % 2    7 / 3     1 / 1       .
--VI |  5:  7 % 2    3 % 1    3 % 1    13 / 5     1 /  1
--VI |  6:  4 % 1    7 % 2    7 % 2    17 / 5     3 /  1
--VI |  7:  9 % 2    4 % 1    4 % 1     4 % 1    53 / 14
--VI |  8:  5 % 1    9 % 2    9 % 2     9 % 2    31 /  7
--VI |  9: 11 % 2    5 % 1    5 % 1     5 % 1     5 %  1
--VI | 10:  6 % 1   11 % 2                       11 %  2

--I | Table I
--I | Expected value of the first letter of a permutation of S_n that consists of a
--I | floor(n/2) cycle AND ceil(n/2) cycle (n >= 2):
--I | [1/1, 7/4, 3/1, 7/2, 4/1, 9/2, 5/1, 11/2]

--II | Table II
--II | Expected value of the first letter of a permutation of S_n whose shortest permutation is >= k:
--II |        1        2        3         4         5
--II |  1:  1 % 1      .        .         .         .
--II |  2:  3 % 2    2 % 1      .         .         .
--II |  3:  2 % 1    5 % 2    5 % 2       .         .
--II |  4:  5 % 2    3 % 1    3 % 1     3 % 1       .
--II |  *:  3 % 1    7 % 2    7 % 2     7 % 2     * /  *
--II |  6:  7 % 2    4 % 1    4 % 1     4 % 1     * /  *
--II |  *:  4 % 1    9 % 2    9 % 2     9 % 2    ** / **
--II |  8:  9 % 2    5 % 1    5 % 1     5 % 1    ** /  *
--II |  9:  5 % 1    * % *    * % *     * % *     * %  *

-- n-2 cycles: 5 % 2, 29 % 11, 19 % 7, 47 % 17, 14 % 5, 65 % 23, 37 % 13]

--III | Table III
--III | One 2-cycle (n >= 2): 2/1, 2/1, 2/1, 3/1, 18/5, 4/1, 130/29, 5/1, 1282/233
--III |                        ?    2    ?    3     ?    4      ?     5       ?
--III | One 3-cycle (n >= 3): 5/2, 5/2, 3/1, 13/4, 4/1, 9/2, 131/26, 11/2
--III |                         ?  2.5, 3,   ?     4,   4.5, ?     , 5.5
--III | One 4-cycle (n >= 4): 3/1, 3/1, 7/2, 4/1, 13/3, 5/1, 11/2
--III |                         ?  3    3.5  4     ?    5    5.5

-- All 1-cycles and 2-cycles: 2/1, 2/1, 7/3, 13/5, 3/1, 37/11, 413/109, 1219/291, 975/211

--IV | Table IV
--IV | Conjecture: the expected value of the first letter of a permutation of [n]
--IV | with k fixed points is (n - k + 2)/2
--IV |         2          3         4         5          6
--IV | 3:    8 %  3       .         .         .          .
--IV | 4:    5 %  2    10 %  3      .         .          .
--IV | 5:   27 % 10     3 %  1    4 %  1      .          .
--IV | 6:   21 %  8    28 %  9    7 %  2    14 % 3       .
--IV | 7:  208 % 75    10 %  3   32 %  9    4  % 1    16 % 3
--IV | 8:   27 % 10    13 %  4   15 %  4    4  % 1    9  % 2
--IV | 9:  105 % 37    10 %  3   55 % 14    25 % 6    40 % 9
--IV | 10:  11 %  4    66 % 19   77 % 20    22 % 5    55 % 12
--IV | 11: 240 % 83   222 % 65   51 % 13

--V | Table V
--V | Notice that the numerator of the i-th term is related to the denominator of
--V | the (i+1)-th term
--V | *Main> map (firstLetterInversion 1) [2..8]
--V | [2/1, 3/2, 4/3, 5/4, 6/5, 7/6, 8/7]
--V |                    *         *
--V | *Main> map (firstLetterInversion 2) [3..10]
--V | [5/2, 9/5, 14/9, 10/7, 27/20, 35/27, 44/35, 27/22]
--V |  ________              ____________
--V |       _________               ____________
--V |                            *             *
--V | *Main> map (firstLetterInversion 3) [4..10] -- A005286
--V | [5/2, 29/15, 49/29, 76/49, 111/76, 155/111, ^CInterrupted.
--V |       ____________
--V |              ____________
--V |                     _____________
--V | *Main> map (firstLetterInversion 4) [5..10]
--V | [49/20, 2/1, 87/49, 95/58, 88/57, 59/40] -- A005287
--V |
--V | *Main> map (firstLetterInversion 5) [6..10] -- A005288
--V | [169/71, 343/169, 628/343, 267/157, 1717/1068]
--V |  _______________
--V |         _________________
