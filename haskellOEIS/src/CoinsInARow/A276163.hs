module CoinsInARow.A276163 (a276163) where
import Helpers.CoinsInARow (minimaxDifference)
import Data.List (permutations)

-- Best score differential for first player (of all possible games)
a276163 :: Int -> Int
a276163 n = maximum $ map minimaxDifference $ permutations [1..n]

histogramSorted :: [Int] -> (Int, [Int])
histogramSorted (n:ns) = (n, recurse n 0 (n:ns)) where
  recurse _ c [] = [c]
  recurse i c as'@(a:as)
    | a == i = recurse i (c+1) as
    | a /= i = c : recurse (i+1) 0 as'
