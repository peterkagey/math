import Helpers.Factorials (binomial, factorial)
import Data.List (permutations, genericLength, sort, (\\))
import Helpers.Table (tableByAntidiagonals)

isValid restrictionSet permutation = all isValidLetter $ zipWith subtract [1..] permutation where
  n = length permutation
  isValidLetter d = all (\s -> (d - s) `mod` n /= 0) restrictionSet

a999999T n = validPermutations [0,n] where
  validPermutations s k = length $ filter (isValid s) $ permutations [1..k]

a999999 n = case tableByAntidiagonals (n - 1) of (m, k) -> a999999T (m + 1) (k + 1)

--  n\k |
--  ----+--------------------------------------
--    1
