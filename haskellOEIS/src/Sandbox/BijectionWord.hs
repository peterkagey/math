module Sandbox.CycleStructure where
import Data.Set (Set)
import qualified Data.Set as Set
import Data.List (permutations, (\\))

type PermutationWord = [Int]
type Cycle = [Int]
type CycleStructure = [[Int]]

fromWord p = recurse 1 [] (Set.fromList [1..length p]) where
  recurse x currentCycle unseen
    | null unseen       = [reverse currentCycle]
    | x `Set.member` unseen = recurse (p !! (x-1)) (x:currentCycle) (Set.delete x unseen)
    | otherwise         = reverse currentCycle : recurse (minimum unseen) [] unseen

st000210 w = minimum $ map maxDifference $ fromWord w

maxDifference :: [Int] -> Int
maxDifference [] = error "This doesn't make sense!"
maxDifference c = maximum c - minimum c
