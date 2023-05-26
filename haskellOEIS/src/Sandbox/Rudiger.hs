import Data.List (genericIndex)

a020639 n = spf a000040_list where
  spf (p:ps) | n < p^2      = n
             | mod n p == 0 = p
             | otherwise    = spf ps

a000040 n = genericIndex a000040_list (n - 1)
a000040_list = base ++ larger where
  base = [2, 3, 5, 7, 11, 13, 17]
  larger = p : filter prime more
  prime n = all ((> 0) . mod n) $ takeWhile (\x -> x*x <= n) larger
  _ : p : more = roll $ makeWheels base
  roll (Wheel n rs) = [n * k + r | k <- [0..], r <- rs]
  makeWheels = foldl nextSize (Wheel 1 [1])
  nextSize (Wheel size bs) p = Wheel (size * p) [r | k <- [0..p-1], b <- bs, let r = size*k+b, mod r p > 0]

data Wheel = Wheel Integer [Integer]

a008365 n = a008365_list !! (n-1)
a008365_list = 1 : filter ((> 11) . a020639) [1..]
