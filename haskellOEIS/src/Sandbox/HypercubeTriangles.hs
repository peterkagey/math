import Data.List (permutations, transpose)
import Helpers.Subsets (choose)
import Helpers.ListHelpers (cartesianProduct)

hypercubeVertices n = cartesianProduct n [0,1]

crossPolytopeVertices n = positive ++ negative where
  positive = map f [0..n-1]
  negative = map (map (0-)) positive
  f k = replicate k 0 ++ 1 : replicate (n-k-1) 0

trianglesInCrossPolytope n      = choose 3 $ crossPolytopeVertices n
trianglesInHypercube n          = choose 3 $ hypercubeVertices n
quadrilateralsInCrossPolytope n = choose 4 $ crossPolytopeVertices n
quadrilateralsInHypercube n     = choose 4 $ hypercubeVertices n

sideLength (v, v') = sum $ map (^2) $ zipWith (-) v v'

isSimplex vs = allEqual $ map (\[x,y] -> sideLength (x, y)) $ choose 2 vs

allEqual [] = True
allEqual (a:as) = all (==a) as

isARectangle [v0, v1, v2, v3] = basis1Square || basis2Square || basis3Square where
  vec1 = zipWith (-) v1 v0
  vec2 = zipWith (-) v2 v0
  vec3 = zipWith (-) v3 v0
  basis1Square = v3 == zipWith (+) v1 vec2
  basis2Square = v2 == zipWith (+) v1 vec3
  basis3Square = v1 == zipWith (+) v2 vec3

isASquare vs@[v0, v1, v2, v3] = isARectangle vs && sidesSameLength where
  vec1 = zipWith (-) v1 v0
  vec2 = zipWith (-) v2 v0
  vec3 = zipWith (-) v3 v0
  len v = sum $ map (^2) v
  sidesSameLength = len vec1 == len vec2 || len vec1 == len vec3 || len vec2 == len vec3

symmetries :: Int -> ([Int] -> [[Int]])
symmetries n = f where
  flips v = map (\fs -> zipWith ($) fs v) $ cartesianProduct n [id, (1-)]
  f v = concatMap flips $ permutations v

canonical :: Int -> [[Int]] -> [[Int]]
canonical n = minimum . transpose . map (symmetries n)

-- This is slow! Use the formula in the OEIS.
-- a344854 :: Integer -> Int
a344854 = length . filter isSimplex . trianglesInHypercube
a130809 = length . filter isSimplex . trianglesInCrossPolytope
a000217 = length . filter isASquare . quadrilateralsInCrossPolytope -- triangular numbers
a345340 = length . filter isASquare . quadrilateralsInHypercube
