import Data.List (nub)
import Helpers.ListHelpers (allDistinct)
import Data.Bits (xor)
-- Say that the first LCM is the sequence a'(n) = LCM(a(n), a(n+1)) and the
-- k-th LCM is the sequence a''(n) = LCM(a'(n), a'(n+1)) and so on,
-- Then this is the lexicographically earliest sequence where all k-th LCMs
-- contain no duplicate values.

lcmList = recurse [] where
  recurse kthDifferences = n : recurse updatedDifferences where
    n = nextTerm kthDifferences
    updatedDifferences = updateDifferences lcm n kthDifferences

updateDifferences :: (Integer -> Integer -> Integer) -> Integer -> [[Integer]] -> [[Integer]]
updateDifferences _ nextTerm [] = [[nextTerm]]
updateDifferences f nextTerm (d:ds) = (nextTerm : d) : updateDifferences f (f x nextTerm) ds where
  x = head d

nextTerm :: [[Integer]] -> Integer
nextTerm ds = head $ filter (isValidConfig ds) [1..]

isValidConfig :: [[Integer]] -> Integer -> Bool
isValidConfig ds n =  all allDistinct $ updateDifferences lcm n ds

x f n = recurse [] where
  recurse triangle = nextTerm : recurse (updateDifferences f nextTerm triangle) where
    nextTerm = head $ filter (`notElem` concat triangle) [n..]

missingNumbers as = recurse as [0..] where
  recurse [] _ = []
  recurse (x:xs) (k:ks)
    | x > k     = k : recurse (x:xs) ks
    | x == k    = recurse xs ks
    | otherwise = error "x < k; this isn't supposed to happen!"
