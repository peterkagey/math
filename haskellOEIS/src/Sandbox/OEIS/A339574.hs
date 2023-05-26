import Helpers.Table (tableByAntidiagonals, antidiagonalize)
import Data.Map (Map)
import qualified Data.Map.Strict as Map
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Maybe (catMaybes)
import Data.List (find)

a339574_list = 1 : recurse 1 (Map.singleton (0,0) (Set.singleton 1)) (Set.singleton 1) where
  recurse n previous allWalks = a_n : recurse (n+1) previous' allWalks' where
    (x, y) = tableByAntidiagonals n
    below = Map.lookup (x, y - 1) previous
    left  = Map.lookup (x - 1, y) previous
    seenValues = unionOfWalks [below, left]
    a_n = head $ filter (`notElem` allWalks) [a339574_list !! (n - 1)..]
    updatedValues = foldr Set.union (Set.singleton a_n) [seenValues, Set.map (+a_n) seenValues]
    previous' = Map.insert (x, y) updatedValues previous
    allWalks' = Set.union allWalks updatedValues

unionOfWalks x = foldr Set.union Set.empty $ catMaybes x
