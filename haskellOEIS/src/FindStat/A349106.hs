module FindStat.A349106 (a349106) where
import FindStat.FindStatHelper (histogramRow, fromWord)
import Data.List (sort)
import qualified Data.Set as Set

st000317 w = sum $ map (\c -> length $ filter (uncurry (>)) $ zip c (tail c)) $ fromWord w

a349106_row n = histogramRow (0, i_max) st000317 n where
  i_max = if n <= 2 then 0 else n - 2

a349106_list = concatMap a349106_row [0..]

a349106 n = a349106_list !! n
