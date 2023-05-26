module Sandbox.Partitions (Partition, partitionsWithMaxPart, partitionsOf) where
import Data.List (tails)

type Partition = [Int]

partitionsOf :: Int -> [Partition]
partitionsOf n = partitionsWithMaxPart n n

partitionsWithMaxPart :: Int -> Int -> [Partition]
partitionsWithMaxPart 0 _ = [[]]
partitionsWithMaxPart n maxPart = concatMap nextGeneration $ reverse [1..maxPart `min` n] where
  nextGeneration firstTerm = map (firstTerm:) $ partitionsWithMaxPart (n - firstTerm) firstTerm

partitionsInto3Parts :: Int -> [(Int, Int, Int)]
partitionsInto3Parts n = [(a, b, n - a - b) | a <- aRange, b <- bRange a] where
  aRange = [(n + 2) `div` 3..n]
  bRange a = [(n - a + 1) `div` 2..min a (n - a)]

palindromeInBase :: Int -> Int -> Bool
palindromeInBase b n = rep == reverse rep where
  rep = baseB b n

baseB b 0 = []
baseB b n = n `mod` b : baseB b (n `div` b)

baseBPalindromes :: Int -> [Int]
baseBPalindromes b = filter (palindromeInBase b) [1..]

-- A261678: Even numbers that are not the sum of two binary palindromes.
-- a(A261678(n)) = 0.
