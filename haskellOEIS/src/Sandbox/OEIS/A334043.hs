import Data.Ratio ((%))
import Data.List (nub)

a334043_list :: [Int]
a334043_list = recurse 1 0 where
  recurse i a_i = a_i : recurse (i + 1) (length $ nub slopes) where
    a334043_list' = zip [1..] $ take (i - 1) a334043_list
    slopes = map (\(j, a_j) -> (a_i - a_j) % (i - j)) a334043_list'

a n = foldl f n [1..n] where
  f m k
    | mod m k == 0 = m `div` k
    | otherwise    = m
