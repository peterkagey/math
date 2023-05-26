module Tables.A342237 (a342237, a342237T) where
import qualified Data.MemoCombinators as Memo
import Helpers.Table (tableByAntidiagonals)

a342237T :: Integer -> Integer -> Integer
a342237T = Memo.memo2 Memo.integral Memo.integral a342237T' where
  a342237T' n 1 = 0
  a342237T' n k
    | even k = n * a342237T n (k - 1) + n^(k `div` 2) - a342237T n (k `div` 2)
    | odd k  = n * a342237T n (k - 1) + n^(k `div` 2 + 1) - a342237T n (k `div` 2 + 1)

a342237 :: Integer -> Integer
a342237 n = case tableByAntidiagonals (n - 1) of (n', k') -> a342237T (n' + 1) (k' + 1)

-- k = 1
-- ceiling((k+1)/2) = 1

-- k = 2
-- ceiling((k+1)/2) = 2

-- k = 3
-- ceiling((k+1)/2) = 2
