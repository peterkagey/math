import Helpers.Factorials (binomial, factorial)
import Data.List (permutations, genericLength, sort, (\\))
import qualified Data.MemoCombinators as Memo

a332709T :: Integer -> Integer -> Integer
a332709T n k
  | k < 3     = 0
  | k > n     = 0
  | otherwise = sum $ map f [0..n-1] where
  f i = coefficient * sum (map g [lower..upper]) where
    lower = max 0 (i + k - n - 1)
    upper = min i (k - 2)
    coefficient = factorial (n - i - 1) * (-1)^i
    g j = binomial (2*k-j-4) j * binomial (2*(n-k+1)-i+j) (i-j)

a332710 n = a332709T n $ (n + 3) `div` 2

(.+.) :: [Integer] -> [Integer] -> [Integer]
(.+.) p1 [] = p1
(.+.) [] p2 = p2
(.+.) (a:p1) (b:p2) = (a + b) : (p1 .+. p2)

(.*.) :: [Integer] -> [Integer] -> [Integer]
(.*.) p1 [] = []
(.*.) [] p2 = []
(.*.) p1 p2 = foldr1 (.+.) termwiseProduct where
  termwiseProduct = map (\(i,x) -> replicate i 0 ++ map (*x) p2) $ zip [0..] p1

poly :: Integer -> [Integer]
poly = Memo.integral poly' where
  poly' 0 = [1]
  poly' 1 = [1,1]
  poly' n = poly (n - 1) .+. ([0,1] .*. poly (n-2))

-- Takes a prefix (in ascending order) and gives the sizes of the blocks.
partitionFrom :: Integer -> [Integer] -> [Integer]
partitionFrom n prefix = lowerTriangular : upperTriangular : map exes regions where
  prefix' = sort prefix
  a_1 = head prefix'
  a_n = last prefix'
  m = genericLength prefix
  exes (a, b)
    | m < a     = 2*b - 2*a - 2
    | m < b - 1 = 2*b - 2*m - 3
    | otherwise = 0
  lowerTriangular
    | a_1 /= 1  = 2*(n - a_n) + 1
    | m < a_n   = 2*(n - a_n)
    | otherwise = 2*(n - a_n) - 1
  upperTriangular = exes (1, a_1)
  regions = zip prefix' (tail prefix')

-- Takes a prefix and gives the sizes of the blocks.
partitionFrom' n prefix = dropWhile (==0) $ sort $ partitionFrom n (sort prefix)

countPermutations :: Integer -> [Integer] -> Integer
countPermutations n prefix
  | menageFailure = 0
  | otherwise     = altSeries $ zipWith (*) (map factorial [m,m-1..0]) boardPolynomial where
    menageFailure = isIllegalMenage n prefix
    m = n - genericLength prefix
    restrictionPartition = dropWhile (<1) $ sort $ partitionFrom n prefix
    boardPolynomial = foldr ((.*.) . poly) [1] restrictionPartition

altSeries :: Num a => [a] -> a
altSeries xs = sum (zipWith (*) (cycle [1, -1]) xs)

isIllegalMenage :: Integral a => a -> [a] -> Bool
isIllegalMenage n prefix = any illegalLetter $ zip [1..] prefix where
  illegalLetter (i, a_i) = i == a_i || (a_i - i) `mod` n == 1

nextDerangement :: Integer -> [Integer] -> [Integer]
nextDerangement n prefix
  | null candidates = nextDerangement n knownPrefix
  | otherwise = knownPrefix ++ [head candidates] where
  x = last prefix
  knownPrefix = init prefix
  index = genericLength prefix
  illegalLetters = map (\i -> (i - 1) `mod` n + 1) [index, index + 1]
  candidates = foldl (\\) [x+1..n] [knownPrefix] --, illegalLetters]

appendNewLetter :: Integer -> [Integer] -> [Integer]
appendNewLetter n prefix
  | null candidates = nextDerangement n $ init prefix
  | otherwise = prefix ++ [head candidates] where
  index = genericLength prefix + 1
  illegalLetters = map (\i -> (i - 1) `mod` n + 1) [index, index + 1]
  candidates = foldl (\\) [1..n] [prefix, illegalLetters]

-- Finds the i-th menage permutation in S_n.
richardsFunction :: Integer -> Integer -> [Integer]
richardsFunction n k = recurse 0 [3] where
  recurse c known
    | c' < k = recurse c' $ nextDerangement n known
    | c' == k && genericLength known == n = known
    | otherwise = recurse c $ appendNewLetter n known where
      c' = c + countPermutations n known

--  1: [3,1,5,2,4]
--  2: [3,4,5,1,2]
--  3: [3,5,1,2,4]
--  4: [3,5,2,1,4]
--  5: [4,1,5,2,3]
--  6: [4,1,5,3,2]
--  7: [4,5,1,2,3]
--  8: [4,5,1,3,2]
--  9: [4,5,2,1,3]
-- 10: [5,1,2,3,4]
-- 11: [5,4,1,2,3]
-- 12: [5,4,1,3,2]
-- 13: [5,4,2,1,3]
