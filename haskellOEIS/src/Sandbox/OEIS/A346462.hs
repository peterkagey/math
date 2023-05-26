import Data.List (permutations)

x = permutations [1..5]

stat pi = length $ filter (id) $ zipWith (||) (False:diffs) (diffs ++ [False]) where
  diffs = zipWith (\a b -> 1 ==  abs (a-b)) pi (tail pi)
