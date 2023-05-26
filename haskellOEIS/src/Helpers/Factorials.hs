module Helpers.Factorials (binomial, factorial) where

factorial :: Integer -> Integer
factorial n = factorial' n 1 where
  factorial' 0 accum = accum
  factorial' n accum = factorial' (n - 1) (accum * n)

binomial :: Integer -> Integer -> Integer
binomial _ 0 = 1
binomial 0 _ = 0
binomial n k
  | n < k'    = 0
  | otherwise = product [k' + 1..n] `div` factorial (n - k') where
    k' = max k (n - k)
