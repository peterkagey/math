import Helpers.ListHelpers (cartesianProduct)
-- The polynomial a + bx + cx^2 ... is represented as
-- [a, b, c, ...]

(.+.) :: [Integer] -> [Integer] -> [Integer]
(.+.) p1 [] = p1
(.+.) [] p2 = p2
(.+.) (a:p1) (b:p2) = (a + b) : (p1 .+. p2)

(.*.) :: [Integer] -> [Integer] -> [Integer]
(.*.) p1 [] = []
(.*.) [] p2 = []
(.*.) p1 p2 = foldr1 (.+.) termwiseProduct where
  termwiseProduct = map (\(i,x) -> replicate i 0 ++ map (*x) p2) $ zip [0..] p1

polynomials 0 = [[1]]
polynomials n = concatMap (\p -> [1:p, 0:p]) $ polynomials (n-1)

isInteresting :: [Integer] -> Bool
isInteresting p = thickness' p > thickness p

a344036 = length . filter isInteresting . polynomials

thickness p = maximum (p .*. p)
thickness' p = maximum (p' .*. p') where
  p' = p .*. [0,1] .+. [1]
