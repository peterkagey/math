import Helpers.ListHelpers (cartesianProduct)

isVisible [(x1,y1),(x2,y2)] = 1 == gcd (x1 - x2) (y1 - y2)

-- Probably correct.
a331771 n = length $ filter isVisible $ cartesianProduct 2 points where
  points = [(x, y) | x <- [1..n], y <- [1..n]]
