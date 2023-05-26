import Data.List (tails)
import Helpers.Factorials (binomial)
import Helpers.Records (allMax, allMin, countMax, countMin, maxIndices)
-- Squares and above.
powerTable :: [[Int]]
powerTable = map (\k -> map (^k) [0..]) [2..]

figurateTable :: [[Int]]
figurateTable = map (\k -> map (\n -> ((k-2)*n^2 + (4-k)*n) `div` 2) [0..]) [3..]

figurateTable' :: [[Int]]
figurateTable' = map (\k -> map (\n -> ((k-2)*n^2 + (4-k)*n) `div` 2) [1..]) [3..]

centeredTable :: [[Int]]
centeredTable = map (\k -> map (\n -> k * n * (n+1) `div` 2 + 1) [0..]) [3..]

simplexTable :: [[Int]]
simplexTable = map (\k -> map (`binomial` k) [k-1..]) [2..]

differenceCount :: Int -> [Int] -> Int
differenceCount n as = length $ filter isValid $ tails validTerms where
  isValid []     = False
  isValid (k:ks) = (n + k) `elem` ks
  -- All terms such that the gap with next neighbor is not greater than n.
  validTerms = head as : map snd (takeWhile (\(x,y) -> y - x <= n) $ zip as (tail as))

-- differenceCount' :: Int -> [Int] -> Int
differenceCount' n as = filter isValid $ tails validTerms where
  isValid []     = False
  isValid (k:ks) = (n + k) `elem` ks
  -- All terms such that the gap with next neighbor is not greater than n.
  validTerms = head as : map snd (takeWhile (\(x,y) -> y - x <= n) $ zip as (tail as))

a333880 :: Int -> Int
a333880 n = sum $ map (differenceCount n) table where
  table = takeWhile (\r -> r !! 2 <= n + 1) powerTable

a333822 :: Int -> Int
a333822 n = sum $ map (differenceCount n) table where
  table = takeWhile (\r -> r !! 2 <= n + 1) figurateTable

a333836 :: Int -> Int
a333836 n = sum $ map (differenceCount n) table where
  table = takeWhile (\r -> r !! 1 <= n + 1) figurateTable'

a333868 :: Int -> Int
a333868 n = sum $ map (differenceCount n) table where
  table = takeWhile (\r -> r !! 2 <= n + 1) simplexTable

-- a999999 :: Int -> Int
a999999 n = map (differenceCount n) table where
  table = takeWhile (\r -> r !! 1 <= n + 1) centeredTable
