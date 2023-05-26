import Math.NumberTheory.Powers.Squares (exactSquareRoot)
import Data.Foldable
compositions :: Int -> [[Int]]
compositions 0 = [[]]
compositions n = concatMap (\k -> map (k:) $ compositions (n-k)) [1..n]

-- Very closely related to A228352.
f k n = sum $ map ((k^) . numberOfOnes) $ compositions n where
  numberOfOnes = length . filter (== 1)

a000079 = f 1
a001519 = f 2
a007052 = f 3
a018902 = f 4
a018903 = f 5
a018904 = f 6

a000027 n = f n 1
a002522 n = f n 2
a135859 n = f n 3 -- Number of binary 3 X (n-1) matrices such that each row and column has at most one 1.

-- 1 2  4   8    16    32 64 128 256 512
-- 2 5  13  34   89    233 610 1597 4181 10946
-- 3 10 34  116  396   1352 4616 15760 53808 183712
-- 4 17 73  314  1351  5813 25012 107621 463069 1992482
-- 5 26 136 712  3728  19520 102208 535168 2802176 14672384
-- 6 37 229 1418 8781  54377 336734 2085253 12913101 79965442
-- 7 50 358 2564 18364 131528 942040 6747152 48324976 346116896

a337243order c1 c2
  | sum c1 < sum c2       = LT
  | sum c1 > sum c2       = GT
  | length c1 < length c2 = LT
  | length c1 > length c2 = GT
  | otherwise = compare (reverse c1) (reverse c2)


flatMap f = concatMap (Data.Foldable.toList . f)

g x = foldl maybeRoot (Just 0) x

-- f ::
maybeRoot a2 a1 = exactSquareRoot =<< fmap (+a1) a2
