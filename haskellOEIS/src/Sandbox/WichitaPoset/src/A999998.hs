module Poset.A999998 (a999998) where
import Poset.Wichita (parents, wichitaRanks)
import Data.Set (Set)
import qualified Data.Set as Set

a999998_row :: Integer -> [Integer]
a999998_row = Set.toAscList . parents

a999998_list :: [Integer]
a999998_list = concatMap a999998_row [1..]

a999998 :: Int -> Integer
a999998 n = a999998_list !! (n - 1)
