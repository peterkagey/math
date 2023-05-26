import Data.List (permutations)
type Permutation = [Int]

mDescents :: Int -> Permutation -> Int
mDescents m x = length $ filter (uncurry (>)) $ x `zip` drop m x
