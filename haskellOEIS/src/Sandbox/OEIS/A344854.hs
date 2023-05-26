import Data.List (permutations, transpose)
import Helpers.Subsets (choose)
import Helpers.ListHelpers (cartesianProduct)

vertices n = cartesianProduct n [0,1]
triangles n = choose 3 $ vertices n

isEquilateral [v1, v2, v3] = e1 == e2 && e2 == e3 where
  e1 = sideLength (v1, v2)
  e2 = sideLength (v2, v3)
  e3 = sideLength (v3, v1)
  sideLength (v, v') = sum $ map (^2) $ zipWith (-) v v'

symmetries :: Int -> ([Int] -> [[Int]])
symmetries n = f where
  flips v = map (\fs -> zipWith ($) fs v) $ cartesianProduct n [id, (1-)]
  f v = concatMap flips $ permutations v

canonical :: Int -> [[Int]] -> [[Int]]
canonical n = minimum . transpose . map (symmetries n)

-- This is slow! Use the formula in the OEIS.
a344854 :: Integer -> Int
a344854 = length . filter isEquilateral . triangles
