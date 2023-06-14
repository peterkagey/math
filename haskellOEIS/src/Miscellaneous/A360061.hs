module Miscellaneous.A360061 (a360061) where
import Data.Numbers.Primes (isPrime)

a360061_list = 2 : 3 : recurse 4 13 where
  recurse n p
    | isPrime(n^2 + p) = n : recurse (n+1) (n^2 + p)
    | otherwise        = recurse (n+1) p

a360061 n = a360061_list !! (n - 1)
