import Math.NumberTheory.Powers.Fourth (isFourthPower')
import Data.List (nub, subsequences)
import Helpers.Primes (primePowers)

raiseUp' :: [Integer] -> [[(Integer, Int)]]
raiseUp' = foldr (\a -> concatMap (\ts -> [(a, 1) : ts, (a, 2) : ts, (a, 3) : ts])) [[]]

a328045_list :: [Integer]
a328045_list = [0, 1, 4, 6, 4, 10, 9, 14, 15, 9, 18, 22, 20, 26, 21, 24, 16, 34, 27, 38, 25, 28, 33, 46, 30, 25, 39, 35, 36, 58, 40, 62, 42, 44, 51, 45, 36, 74, 57, 52, 49, 82, 50, 86, 55, 54, 69, 94, 54, 49, 63, 68, 65, 106]

baseCandidates :: Int -> [Integer]
baseCandidates n = filter (not . isInvalid) [n'+1..g_n-1] where
  n' = fromIntegral n
  g_n = a328045_list !! n
  isInvalid k = any (\p -> k - p < n' && k + p > g_n) unpairedPrimes where
    unpairedPrimes = map fst $ filter (\(_,p) -> p `mod` 2 == 1) $ primePowers $ fromIntegral k

count n = map (\x -> prefix ++ x) $ subsequences $ baseCandidates n where
  n' = fromIntegral n
  prefix = nub [n', g_n]
  g_n = a328045_list !! n

a999999' n = filter (isFourthPower' . powerProduct) r where
  r = concatMap raiseUp' $ count n

a999999'_list = map a999999' [1..]

powerProduct :: [(Integer, Int)] -> Integer
powerProduct = product . map (uncurry (^))

-- (zero indexed)
--  0 3     = 2^0  * 3
--  1 3     = 2^0  * 3
--  2 2
--  3 2
--  4 1
--  5 12    = 2^2  * 3
--  6 2
--  7 12    = 2^2  * 3
--  8 12    = 2^2  * 3
--  9 1
-- 10 12    = 2^2  * 3
-- 11 192   = 2^6  * 3
-- 12 12    = 2^2  * 3
-- 13 768   = 2^8  * 3
-- 14 12    = 2^2  * 3
-- 15 12    = 2^2  * 3
-- 16 3     = 2^0  * 3
-- 17 12288 = 2^12 * 3
-- 18 12    = 2^2  * 3
-- 19 49152 = 2^14 * 3
-- 20 2
-- 21 6     = 2^1  * 3
-- 22 48    = 2^4  * 3
-- 23 ******
-- 24 2
-- 25 1
-- 26 48    = 2^4  * 3
-- 27 3     = 2^0  * 3
-- 28 2
-- 29 ******
-- 30 2
-- 31 ******
-- 32 2
-- 33 6     = 2^1  * 3
-- 34 768   = 2^8  * 3
-- 35 2
-- 36 1
