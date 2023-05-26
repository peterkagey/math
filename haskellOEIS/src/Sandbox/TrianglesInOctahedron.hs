import Helpers.Subsets (choose)

octahedron n = [(x,y,z) | x <- [-n..n], y <- [(abs x) - n..n - (abs x)], z <- [(abs x) + (abs y) - n..n - (abs x) - (abs y)]]

isEquilateral :: [(Int, Int, Int)] -> Bool
isEquilateral [(x1,y1,z1),(x2,y2,z2),(x3,y3,z3)] = d1 == d2 && d2 == d3 where
  d1 = (x1-x2)^2 + (y1-y2)^2 + (z1-z2)^2
  d2 = (x1-x3)^2 + (y1-y3)^2 + (z1-z3)^2
  d3 = (x3-x2)^2 + (y3-y2)^2 + (z3-z2)^2
