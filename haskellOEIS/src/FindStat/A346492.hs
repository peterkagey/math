module FindStat.A346492 (a346492) where
import FindStat.FindStatHelper (histogramRow, fromWord)

maxDifference :: [Int] -> Int
maxDifference [] = error "This doesn't make sense!"
maxDifference c = maximum c - minimum c

st000210 w = minimum $ map maxDifference $ fromWord w

a346492_row n = histogramRow (0, n-1) st000210 n

a346492_list = concatMap a346492_row [1..]

a346492 n = a346492_list !! (n - 1)
