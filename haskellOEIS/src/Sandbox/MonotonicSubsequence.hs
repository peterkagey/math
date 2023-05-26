import Data.List (tails)
import Data.Ord (comparing)

-- Length of the longest monotonic increasing subsequence of (a_1,a_2,...)
-- that starts with a_1.
longestMonotonicIncreasing :: (Num p, Ord p, Ord a) => [a] -> p
longestMonotonicIncreasing [] = 0
longestMonotonicIncreasing (x:xs) = recurse xs [(x, 1)] where
  recurse     [] known = maximum $ map snd known
  recurse (y:ys) known
   | y < x     = recurse ys known
   | otherwise = recurse ys ((y, 1 + newValue) : known) where
     newValue = maximum $ map snd $ filter (\(a, b) -> y >= a) known

-- Length of the longest monotonic decreasing subsequence of (a_1,a_2,...)
-- that starts with a_1.
longestMonotonicDecreasing [] = 0
longestMonotonicDecreasing (x:xs) = recurse xs [(x, 1)] where
  recurse     [] known = maximum $ map snd known
  recurse (y:ys) known
    | y > x     = recurse ys known
    | otherwise = recurse ys ((y, 1 + newValue) : known) where
      newValue = maximum $ map snd $ filter (\(a, b) -> y <= a) known

-- Length of the longest monotonic subsequence of (a_1,a_2,...)
-- that starts with a_1.
longestMonotonic xs = longestMonotonicIncreasing xs `max` longestMonotonicDecreasing xs

-- Length of the longest monotonic subsequence.
longestMonotonic' :: (Num a, Ord a, Ord b) => [b] -> a
longestMonotonic' = maximum . map longestMonotonic . tails
