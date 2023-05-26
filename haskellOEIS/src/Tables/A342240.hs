module Tables.A342240 (a342240, a342240T) where
import Tables.A342239 (a342239T)
import Helpers.Table (tableByAntidiagonals)

a342240T :: Integer -> Integer -> Integer
a342240T n k = n^k - a342239T n k

a342240 :: Integer -> Integer
a342240 n = case tableByAntidiagonals (n - 1) of (n', k') -> a342240T (n' + 1) (k' + 1)
