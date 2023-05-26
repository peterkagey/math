module Poset.A999999 (a999999) where
import Poset.Wichita (children, wichitaRanks)
import Data.Set (Set)
import qualified Data.Set as Set

a999999_row :: Integer -> [Integer]
a999999_row = Set.toAscList . children

a999999_list :: [Integer]
a999999_list = concatMap a999999_row [1..]

a999999 :: Int -> Integer
a999999 n = a999999_list !! (n - 1)
