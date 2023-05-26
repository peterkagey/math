import Data.List (tails)
import Math.NumberTheory.Powers.Squares (isSquare')
import Helpers.ListHelpers (firstDifferences)

triangles = map (\n -> n * (n + 1) `div` 2) [1..]
squares   = map (^2) [1..]
pentagons = map (\n -> n*(3*n - 1) `div` 2) [1..]

a000404_list :: [Integer]
a000404_list = sumOfTwo squares

a003325_list :: [Integer]
a003325_list = sumOfTwo cubes where
  cubes = map (^3) [1..]

a051533_list :: [Integer]
a051533_list = sumOfTwo triangles

a102798_list :: [Integer]
a102798_list = sumOfTwo tetrahedra where
  tetrahedra = map (\n -> (n^3+3*n^2+2*n) `div` 6) [0..]

a286636_list :: [Integer]
a286636_list = sumOfTwo centeredSquares where
  centeredSquares = map (\n -> 2*n*(n+1)+1) [0..]

a287960_list :: [Integer]
a287960_list = sumOfTwo centeredTriangles where
  centeredTriangles = map (\n -> 3*n*(n-1) `div` 2 + 1) [1..]

a288631_list :: [Integer]
a288631_list = sumOfTwo pyramids where
  pyramids = map (\n -> (2*n^3+3*n^2+n) `div` 6) [1..]

a330031_list :: [Integer]
a330031_list = sumOfTwo tetrahedra where
  tetrahedra = map (\n -> (n^3+3*n^2+2*n) `div` 6) [1..]

a332984_list :: [Integer]
a332984_list = sumOfTwo' pentagons triangles

a332987_list :: [Integer]
a332987_list = sumOfTwo pentagons

a333007_list :: [Integer]
a333007_list = sumOfTwo' pentagons squares

------------------------------------------------------------

sumOfTwo :: [Integer] -> [Integer]
sumOfTwo figurate = recurse $ figurate `zip` tails figurate where
  recurse ls = minVal : recurse ls' where
      minVal = findMin ls
      ls' = deleteSums minVal ls

sumOfTwo' :: [Integer] -> [Integer] -> [Integer]
sumOfTwo' as bs = recurse bs $ as `zip` tails as where
  recurse (t:t':ts) ls
    | minVal == t = minVal : recurse (t':ts) ls'
    | otherwise   = recurse (t':ts) ls' where
      minVal = findMin ls
      ls' = deleteSums' t' ls

findMin :: [(Integer, [Integer])] -> Integer
findMin ((a,b:_):ps) = recurse (a + b) ps where
  recurse knownMin ((a',b':_):ps')
    | a' >= knownMin = knownMin
    | otherwise     = recurse (min knownMin (a' + b')) ps'

deleteSums :: Integer -> [(Integer, [Integer])] -> [(Integer, [Integer])]
deleteSums n ((a,b:bs):ps)
  | a > n     = (a,b:bs) : ps
  | a + b == n = (a,bs) : deleteSums n ps
  | otherwise  = (a,b:bs) : deleteSums n ps

-- Deletes all sums (a + b) < n
deleteSums' :: Integer -> [(Integer, [Integer])] -> [(Integer, [Integer])]
deleteSums' n ((a,bs):ps)
  | a > n     = (a,bs) : ps
  | otherwise = (a, dropWhile (<(n - a)) bs) : deleteSums' n ps
