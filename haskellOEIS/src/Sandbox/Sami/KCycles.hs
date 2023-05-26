import Helpers.Factorials (binomial, factorial)
import Data.Ratio ((%))
-- Probably would be smart to cache this.
c k n m
    | m < 0     = 0
    | m == 0    = f k n
    | otherwise = factorial (k - 1) * (n `binomial` k) * c k (n-k) (m-1) `div` m

f k n = sum $ map (\i -> factorial n * (-1)^i `div` k^i `div` factorial i) [0..n `div` k]

e k n m = half * (one - (numer % denom)) + one where
    one = 1 % 1
    numer = c k (n-1) m
    denom = c k n m
    half = n % 2

error2 n m = sign * semifactorial * (b1 + b2) where
    sign = (-1)^(n' + m + 1)
    semifactorial = product [1,3..n]
    n' = (n - 1) `div` 2
    b1 = n' `binomial` (m - 1)
    b2 = n' `binomial` m

er :: Integral a => a -> a -> a -> a
er k n m = c k n m - n * c k (n-1) m

er' k n m
    | n `mod` k /= 0 = 0
    | otherwise = ((-1)^(n' + m)) *(binomial n' m) * (factorial n) `div` (factorial n') `div` (k^n') where
        n' = n `div` k

-- k = 2
--

-- k = 3
--    -2    2
--    40  -80    40
-- -2240 6720 -6720 2240

