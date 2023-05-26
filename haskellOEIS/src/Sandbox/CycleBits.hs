import Data.Bits
import Data.List (elemIndex, sort)
import Data.Maybe (mapMaybe)
-- 0
-- 1
-- 10 -> 11
-- 11 -> 00
-- 100 -> 101
-- 101 -> 110
-- 110 -> 011
-- 111 -> 000

-- (Positive rotate)
--   111010
-- ^ 110101
-- --------

-- (Negative rotate)
--   111010
-- ^ 011101
-- --------

-- -- 111010 -> 100000 + 011010

a 0 = error "xxx"
a n = (n - k) * 2 + 1 where
  k = last $ takeWhile (<=n) $ map (2^) [0..]

rotateWidth k n
  | n >= 2^(k-1) = 2 * (n - 2^(k-1)) + 1
  | otherwise    = 2 * n

invertPermutation p = mapMaybe (`elemIndex` p) $ sort p
