module HelperSequences.A000354 (a000354) where
import qualified Data.MemoCombinators as Memo

a000354 = Memo.integral a000354' where
  a000354' 0 = 1
  a000354' n = 2 * n * a000354' (n-1) + (-1)^n
