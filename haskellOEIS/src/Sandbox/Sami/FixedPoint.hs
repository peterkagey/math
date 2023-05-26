import Data.List (permutations)
import Data.MemoCombinators (memo2, integral)

type Permutation = [Int]

fixedPoints :: Permutation -> Int
fixedPoints p = length $ filter (uncurry (==)) $ [1..] `zip` p

-- f'' n m = length $ filter ((==m) . fixedPoints) $ permutations [1..n]

f n m
  | m > n      = 0
  | m < 0      = 0
  | m == n - 1 = 0
  | n == 1     = 1
  | otherwise  = f' (n-1) (m-1) + (n - m - 1) * f' (n - 1) m + (m + 1) * f' (n-1) (m + 1)

f' = memo2 integral integral f

twiceE n m
  | m == n - 1 = 0
  | otherwise  = n - m + 2

-- lhs n m = f' n m * twiceE n m `div` 2

-- g a n m
--   | a == 1    = f (n-1) (m-1)
--   | otherwise = f (n-1) m - f (n-2) (m-1) + f (n - 2) m
--
-- rhs n m = sum $ map (\a -> g a n m * a) [1..n]
