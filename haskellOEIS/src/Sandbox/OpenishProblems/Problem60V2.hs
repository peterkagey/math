module Miscellaneous.Problem70 where
import Data.List (permutations, subsequences, nub)

--  1,2,5,9,17,30
a n = maximum $ map (count (comparisons . pairs)) $ combination n [1..n]

-- 1,2,5,9,16,26
a' n = maximum $ map (count (deduplicate . comparisons . pairs)) $ combination n [1..n]

count differences xs = length $ nub $ map differences $ subsequences xs

pairs xs = zip xs (tail xs)

comparisons = map (uncurry compare)

deduplicate :: Eq a => [a] -> [a]
deduplicate [] = []
deduplicate [a] = [a]
deduplicate (a_1 : a_2 : as)
  | a_1 == a_2 = deduplicate (a_2:as)
  | otherwise  = a_1 : deduplicate (a_2:as)

-- https://stackoverflow.com/a/21775467
combination n xs = mapM (const xs) [1..n]
