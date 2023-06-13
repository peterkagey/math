import Helpers.Subsets (eachPair,  choose)
import Data.Set (Set)
import qualified Data.Set as Set
import Helpers.Table (indicesByAntidiagonals)

-- Given S computes |S+S|,  the size of the pairwise sum.
sumCount as = Set.size $ Set.fromList $ map (uncurry (+)) pairs where
  pairs = eachPair as ++ zip as as

isMaximalSumCount as = sumCount as == (x*(x+1) `div` 2) where
  x = length as

allSequencesOfLengthK k = recurse [] k where
  recurse known c = known ++ recurse known' (c+1) where
    known' =  map (++ [c]) $ choose (k-1) [1..c-1]

-- head $ filter isMaximalSumCount $ allSequencesOfLengthK 3

choose' :: (Eq t,  Num t) => t -> [a] -> [[a]]
choose' 0 _ = [[]]
choose' _ [] = []
choose' n xs'@(x:xs) = [x : subs | subs <- choose' (n-1) xs'] ++ choose' n xs

-- (n+2) choose 3

sillyList :: Integer -> [Integer]
sillyList n = recurse 1 [] where
  recurse k knownTerms
    | length tuples == Set.size sums = k : recurse (k+1) (k:knownTerms)
    | otherwise                        = recurse (k+1) knownTerms where
      tuples = choose' n (k:knownTerms)
      sums = Set.fromList $ map sum tuples

-- [[1, 2,  3,  4,   5,    6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31], [1, 2,  4,  8,  13,   21, 31, 45, 66, 81, 97, 123, 148, 182, 204, 252, 290, 361, 401, 475, 565, 593, 662, 775, 822, 916, 970, 1016, 1159, 1312, 1395, 1523, 1572, 1821, 1896, 2029, 2254, 2379, 2510], [1, 2,  5, 14,  33,   72, 125, 219, 376, 573, 745, 1209, 1557], [1, 2,  6, 22,  56,  154, 369, 857, 1425, 2604, 4968], [1, 2,  7, 32, 109,  367, 927, 2287], [1, 2,  8, 44, 155,  669, 2215], [1, 2,  9, 58, 257, 1154], [1, 2, 10, 74, 334, 1823]]
---------------------------
-- 1: 1, 2,  3,  4,   5,    6,    7,     8,    9,   10,   11,   12,   13, ...
-- 2: 1, 2,  4,  8,  13,   21,   31,    45,   66,   81,   97,  123,  148, ...
-- 3: 1, 2,  5, 14,  33,   72,  125,   219,  376,  573,  745, 1209, 1557,
-- 4: 1, 2,  6, 22,  56,  154,  369,   857, 1425, 2604, 4968, ...
-- 5: 1, 2,  7, 32, 109,  367,  927,  2287, ...
-- 6: 1, 2,  8, 44, 155,  669, 2215,  6877, ...
-- 7: 1, 2,  9, 58, 257, 1154, 4182, 14181, ...
-- 8: 1, 2, 10, 74, 334, 1823, 8044, _____, ...
