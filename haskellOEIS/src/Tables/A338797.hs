module Tables.A338797 (a338797) where
import Helpers.Table (triangleByRows)
import Data.Ratio ((%), denominator)

farey n = [k % n | k <- [1..n], gcd n k == 1]

a338797T n k = minimum [denominator $ a + b | a <- farey n, b <- farey k]

a338797_row n = map (a338797T n) [1..n]

a338797_list :: [Integer]
a338797_list = concatMap a338797_row [1..]

a338797 :: Int -> Integer
a338797 n = a338797_list !! (n - 1)
