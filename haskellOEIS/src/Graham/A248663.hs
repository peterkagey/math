module Graham.A248663 (a248663) where
import HelperSequences.A112798 (a112798_row)
import Data.Bits (xor)

a248663 :: Integer -> Integer
a248663 = foldr (xor . f) 0 . a112798_row where
  f i = 2^(i - 1)
