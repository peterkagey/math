module Polynomial.A350532 (a350532) where
import Helpers.ListHelpers (cartesianProduct)
import Helpers.Primes (divisors)
import Data.List (sort)
import Data.Set (Set)
import qualified Data.Set as Set

type CoefficientList = [Int]

-- polynomials of degree n with coefficients in Z/2Z of the form f(x)^m for some m > 1
targetPolynomialsWithMultiplicity :: Int -> [CoefficientList]
targetPolynomialsWithMultiplicity n = concatMap f factors where
  factors = tail $ map fromIntegral $ divisors (fromIntegral n)
  -- f :: Int -> [CoefficientList]
  f d = map (map (`mod` 2) . (`power` d)) $ allCoefficientLists a where
    a = n `div` d

targetPolynomials :: Int -> Set CoefficientList
targetPolynomials = Set.fromList . targetPolynomialsWithMultiplicity

allCoefficientLists :: Int -> [CoefficientList]
allCoefficientLists 0 = [[1]]
allCoefficientLists n = map (1:) $ cartesianProduct n [0,1]

-- Scalar multiplication
(.*) :: Int -> CoefficientList -> CoefficientList
x .* ys = map (x*) ys

-- Vector addition
(.+.) :: CoefficientList -> CoefficientList -> CoefficientList
[] .+. g  = g
f  .+. [] = f
(f:fs) .+. (g:gs) = (f+g) : (fs .+. gs)

-- https://byorgey.wordpress.com/2008/04/22/list-convolutions/
-- Convolution
(.*.) :: CoefficientList -> CoefficientList -> CoefficientList
f .*. [] = []
[] .*. g = []
[f] .*. [g] = [f*g] -- To avoid trailing zero from below.
(f:fs) .*. (g:gs) = f*g : ((f.*gs) .+. (g.*fs) .+. (0 : fs.*.gs))

-- k-repeated convolution
power :: CoefficientList -> Int -> CoefficientList
power p k = iterate (.*. p)  [1] !! k

histogramSorted :: [Int] -> [Int]
histogramSorted = recurse 0 0 where
  recurse _ c [] = [c]
  recurse i c as'@(a:as)
    | a == i = recurse i (c+1) as
    | a /= i = c : recurse (i+1) 0 as'

justifyLeft n c s = s ++ replicate (n - length s) c

a350532_row :: Int -> [Int]
a350532_row 0 = [1]
a350532_row n = justifyLeft (n+1) 0 $ tail $ histogramSorted sortedTermCounts where
  sortedTermCounts = Data.List.sort $ map sum $ Set.toList $ targetPolynomials n

a350532_list :: [Int]
a350532_list = concatMap a350532_row [0..]

a350532 :: Int -> Int
a350532 = (!!) a350532_list
