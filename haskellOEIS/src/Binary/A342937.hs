module Binary.A342937 (a342937, a342937_list) where
import Binary.A324608 (a324608_list)
import Helpers.ListHelpers (runLengths)

a342937_list :: [Int]
a342937_list = runLengths a324608_list

a342937 :: Int -> Int
a342937 n = a342937_list !! (n - 1)
