import Data.List (delete)

a354408_perms n k = recurse 0 [([], [0..n-1])] where
  recurse :: Int -> [([Int], [Int])] -> [[Int]]
  recurse i = concatMap f where
    f :: ([Int], [Int]) -> [[Int]]
    f (known, []) = [known]
    f (known, remaining) = recurse (i + 1) newStates where
      newStates = map (\a -> (a:known, Data.List.delete a remaining)) validLetters
      isInAllowedPosition pi_i = (pi_i /= i) && (pi_i - i - k) `mod` n /= 0
      validLetters = filter isInAllowedPosition remaining

a354408 n k = length $ a354408_perms n k
