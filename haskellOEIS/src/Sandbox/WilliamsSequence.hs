import Helpers.Subsets (choose)
import Data.Set (Set)
import qualified Data.Set as Set

-- Relates to A066063 and
-- William Chang's June 2022 email.

covers n list = targetSet `Set.isSubsetOf` (pairSums list) where
  targetSet = Set.fromList [1..n]

covers' n list = targetSet `Set.isSubsetOf` (pairSums' list) where
  targetSet = Set.fromList [1..n]

pairSums list = Set.fromList [a + b | a <- list, b <- list]

pairSums' list = Set.fromList [a + b | a <- list, b <- dropWhile (<= a) list]

-- Least k such that there is a set S = {a_1, ..., a_k} such that
-- covers' n S is True.
specialList' = recurse 1 2 where
  recurse n k
    | not $ null $ a' n k = k : recurse (n + 1) k
    | otherwise           = recurse n (k + 1) where
      a' n k = filter (covers' n) $ choose k [0..n]

specialList = recurse 1 2 where
  recurse n k
    | not $ null $ a n k = k : recurse (n + 1) k
    | otherwise           = recurse n (k + 1) where
      a n k = filter (covers n) $ choose k [0..n]
