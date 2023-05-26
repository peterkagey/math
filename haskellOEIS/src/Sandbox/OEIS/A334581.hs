import Helpers.Subsets (choose, allSubsets, eachPair)
import Data.Ratio ((%))
import Data.List (sort)
import Helpers.ListHelpers (cartesianProduct)
tetrahedronCoords :: Int -> [[Int]]
tetrahedronCoords n = [[x, y, z, n-1-x-y-z] | x <- [0..n-1], y <- [0..n-1-x], z <- [0..n-1-x-y]]

areEquidistant :: [[Int]] -> Bool
areEquidistant points = allEqual $ map distance $ choose 2 points where
  distance [as, bs] = sum $ map (^2) $ zipWith subtract as bs

allEqual :: Eq a => [a] -> Bool
allEqual as = and $ zipWith (==) as (tail as)

-- 100% brute force.
a334581 :: Int -> Int
a334581 = length . filter areEquidistant . choose 3 . tetrahedronCoords

a269747 = length . filter areEquidistant . choose 4 . tetrahedronCoords

-- distinguishedCoords n = [(x,y,n-1-x-y,0) | x <- [0..n-1], y <- [0..n-1-x] ]

-- coords' n = filter (\(_,_,_,w) -> w > 0) [(x, y, z, n-1-x-y-z) | x <- [0..n-1], y <- [0..n-1-x], z <- [0..n-1-x-y]]

-- triples n = [[(0,0,0,n-1), p, q] | p <- distinguishedCoords n, q <- tetrahedronCoords n]

-- We're considering triangles containing (0,0,0,1) and (x,y,z,0)
-- So that z = n-x-y.

-- notParallel :: [(Int, Int, Int, Int)] -> Bool
-- notParallel points = all (not . allEqual) [first, second, third, fourth] where
--   first  = map (\(p,_,_,_) -> p) points
--   second = map (\(_,p,_,_) -> p) points
--   third  = map (\(_,_,p,_) -> p) points
--   fourth = map (\(_,_,_,p) -> p) points

-- [(0,0,2,3),(0,3,2,0),(3,1,0,1)]
-- [(0,0,2,3),(1,3,0,1),(3,0,2,0)]
-- [(0,0,3,2),(0,3,0,2),(3,1,1,0)]
-- [(0,0,3,2),(1,3,1,0),(3,0,0,2)]
-- [(0,1,1,3),(2,0,3,0),(2,3,0,0)]
-- [(0,1,3,1),(2,0,0,3),(2,3,0,0)]
-- [(0,2,0,3),(0,2,3,0),(3,0,1,1)]
-- [(0,2,0,3),(1,0,3,1),(3,2,0,0)]
-- [(0,2,3,0),(1,0,1,3),(3,2,0,0)]
-- [(0,3,0,2),(1,1,3,0),(3,0,0,2)]
-- [(0,3,1,1),(2,0,0,3),(2,0,3,0)]
-- [(0,3,2,0),(1,1,0,3),(3,0,2,0)]

-- componentwiseMultiply :: [(Int, Int, Int, Int)] -> (Int, Int, Int, Int)
-- componentwiseMultiply (a1, a2, a3, a4) (b1, b2, b3, b4) = (a1 * b1, a2 * b2, a3 * b3, a4 * b4)

-- touchesEverySide :: [(Int, Int, Int, Int)] -> Bool
-- touchesEverySide ps = (0,0,0,0) == foldr1 componentwiseMultiply ps

-- equivalenceClass :: [(Int, Int, Int, Int)] -> [[Int]]
-- equivalenceClass ts = sort $ map sortCoordinates ts where
--   sortCoordinates (p1, p2, p3, p4) = sort [p1, p2, p3, p4]

-- ------------------------------------------

allMin :: (a -> Int) -> [a] -> [a]
allMin _ []     = []
allMin f (a:as) = recurse [a] (f a) as where
  recurse known _ []  = known
  recurse known knownMin (x:xs)
    | f x == knownMin = recurse (x : known) knownMin xs
    | f x > knownMin  = recurse       known knownMin xs
    | otherwise       = recurse         [x]    (f x) xs

isOrthogonal :: [[Int]] -> Bool
isOrthogonal vs = all orthogonal $ eachPair vs where
  orthogonal (v,w) = 0 == sum (zipWith (*) v w)

isHypercube :: [[Int]] -> Bool
isHypercube [] = False
isHypercube ps'@(p:ps) = orthogonal && sort basis == sort ps' where
  basis = map (foldr (zipWith (+)) p) $ allSubsets vectors
  orthogonal = isOrthogonal vectors
  vectors = allMin norm $ map (zipWith subtract p) ps where
    norm coords = sum $ map (^2) coords

-- (???) 3 * A001752
squareInTetrahedron = filter isHypercube . choose 4 . tetrahedronCoords

squareInCube n = filter isHypercube $ choose 4 $ cartesianProduct 3 [1..n]
