module Tables.A342239 (a342239, a342239T) where
import qualified Data.MemoCombinators as Memo
import Helpers.Table (tableByAntidiagonals)


a342239T :: Integer -> Integer -> Integer
a342239T = Memo.memo2 Memo.integral Memo.integral a342239T' where
  a342239T' n 0 = 1
  a342239T' n k
    | odd k  = n * a342239T n (k - 1)
    | even k = n * a342239T n (k - 1) - a342239T n (k `div` 2)

a342239 :: Integer -> Integer
a342239 n = case tableByAntidiagonals (n - 1) of (n', k') -> a342239T (n' + 1) (k' + 1)
