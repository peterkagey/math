import Helpers.Table (triangleByRows)

import Data.Ratio ((%), denominator)
farey n = [k % n | k <- [1..n], gcd n k == 1]
a338797T n k = minimum [denominator $ a + b | a <- farey n, b <- farey k]
