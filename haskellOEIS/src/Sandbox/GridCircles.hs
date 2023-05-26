-- Problem 117
import Data.Ratio ((%))
import Data.List (sort)
-- Assume (x,y) \in [0,1)^2.
circles (x,y) = takeWhile (<= 81 % 1) $ sort [distance (x, y) (a, b) | a <- [-10..10], b <- [-10..10]]

distance (x, y) (a, b) = delX + delY where
  delX
    | a == 0 = 0
    | a > 0  = (a - x)^2
    | a < 0  = (x - 1 - a)^2
  delY
    | b == 0 = 0
    | b > 0  = (b - y)^2
    | b < 0  = (y - 1 - b)^2

histogram [] = []
histogram (a:as) = recurse 1 a as where
  recurse c x [] = [c]
  recurse c x (y:ys)
    | x == y    = recurse (c + 1) x ys
    | otherwise = c : recurse 1 y ys
