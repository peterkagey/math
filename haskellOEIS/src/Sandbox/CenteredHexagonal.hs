import Helpers.Subsets (choose)
-- Points (in 3D) of a centered hexagonal lattice of size n.
-- A002417
type Point = (Int, Int, Int)
type Points = [Point]

hexLatticePoints :: Int -> [Point]
hexLatticePoints n = [(x,y,3*n - x - y) | x <- [0..2*n], y <- [max 0 (n-x)..min (2*n) (3*n - x)]]

isEquilateral :: Points -> Bool
isEquilateral [p1, p2, p3] = s1 == s2 && s2 == s3 where
  s1 = squaredDistance p1 p2
  s2 = squaredDistance p2 p3
  s3 = squaredDistance p3 p1

squaredDistance :: Point -> Point -> Int
squaredDistance (x1,y1,z1) (x2,y2,z2) = (x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2

s n
  | n `mod` 3 == 0 = n `div` 3
  | otherwise      = 0

d n = (n + 1)*(n + 2) `div` 2

a011779 n = s n + sum (map (\i -> s i * d (n - i)) [1..n-1])
