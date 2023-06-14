module FindStat.A346462 (a346462) where
import FindStat.FindStatHelper (histogramRow, fromWord)

st000064 pi = length $ filter id $ zipWith (||) (False:diffs) (diffs ++ [False]) where
  diffs = zipWith (\a b -> 1 ==  abs (a-b)) pi (tail pi)

a346462_row n = histogramRow (0, n) st000064 n

a346462_list = concatMap a346462_row [0..]

a346462 n = a346462_list !! n
