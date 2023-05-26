module Tables.A342238 (a342238, a342238T) where
import Helpers.Table (tableByAntidiagonals)
import Tables.A342237 (a342237T)

a342238T :: Integer -> Integer -> Integer
a342238T n k = n^k - a342237T n k

a342238 :: Integer -> Integer
a342238 n = case tableByAntidiagonals (n - 1) of (n', k') -> a342238T (n' + 1) (k' + 1)
