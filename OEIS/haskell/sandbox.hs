import Data.List

-- A007913: Squarefree part of n: a(n) = smallest positive number m such that n/m is a square.

greatestPower n p k = n `mod` p^k /= n `mod` p^(k+1)

greatestPowerDivisor :: Integer -> Integer -> Integer
greatestPowerDivisor 0 _ = 0
greatestPowerDivisor _ 0 = 0
greatestPowerDivisor _ 1 = 0
greatestPowerDivisor n p = case find(\k->greatestPower n p k)[0..] of
    Just value -> value
    Nothing -> -1
