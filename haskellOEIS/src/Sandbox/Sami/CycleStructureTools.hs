module Sandbox.CycleStructureTools (fromWord, canonicalForm') where
import Data.List (sort, cycle)
import Data.Set (Set)
import qualified Data.Set as Set

type PermutationWord = [Int]
type Cycle = [Int]
type CycleStructure = [[Int]]

fromWord p = canonicalForm $ recurse 1 [] (Set.fromList [1..length p]) where
  recurse x currentCycle unseen
    | null unseen           = [reverse currentCycle]
    | x `Set.member` unseen = recurse (p !! (x-1)) (x:currentCycle) (Set.delete x unseen)
    | otherwise             = reverse currentCycle : recurse (minimum unseen) [] unseen

-- [[4,2],[6,3,1,5]]
canonicalForm :: CycleStructure -> CycleStructure
canonicalForm = sort . map largestFirst where
  largestFirst permutationCycle = case span (< maxValue) permutationCycle of
                                                                            (x,y) -> y ++ x
    where
    maxValue = maximum permutationCycle

-- [[1,5,6,3],[2,4]]
canonicalForm' :: CycleStructure -> CycleStructure
canonicalForm' = sort . map smallestFirst where
  smallestFirst permutationCycle = case span (> minValue) permutationCycle of
                                                                            (x,y) -> y ++ x
    where
    minValue = minimum permutationCycle

permutationProduct :: CycleStructure -> CycleStructure -> CycleStructure
permutationProduct cs1 cs2 = fromWord $ map (a (cs1 ++ cs2)) [1..upperBound] where
  upperBound = maximum $ concat $ cs1 ++ cs2

a cycles n = foldr mapsTo n cycles where
  mapsTo permutationCycle i
    | i `elem` permutationCycle = (!! 1) $ dropWhile (/= i) $ cycle permutationCycle
    | otherwise                 = i

x :: [CycleStructure]
x = [[[1,2]], [[1,2,3]], [[1]], [[1,3,2]]]

firstDifference = permutationProduct . map reverse

firstDifferences ps = zipWith firstDifference ps (tail $ cycle ps)

-- [
--   [[[1,2]],[[1,2,3]],[[1]],[[1,3,2]]],
--   [[[1],[3,2]],[[3,2,1]],[[3,2,1]],[[2],[3,1]]],
--   [[[2,1],[3]],[[1],[2],[3]],[[1],[3,2]],[[3,2,1]]],
--   [[[2,1],[3]],[[1],[3,2]],[[2,1],[3]],[[2],[3,1]]],
--   [[[3,1,2]],[[3,2,1]],[[3,2,1]],[[3,1,2]]], --
--   [[[3,1,2]],[[1],[2],[3]],[[3,2,1]],[[1],[2],[3]]],
--   [[[3,2,1]],[[3,2,1]],[[3,1,2]],[[3,1,2]]],
--   [[[1],[2],[3]],[[3,2,1]],[[1],[2],[3]],[[3,1,2]]],
--   [[[3,2,1]],[[3,1,2]],[[3,1,2]],[[3,2,1]]],
--   [[[3,2,1]],[[1],[2],[3]],[[3,1,2]],[[1],[2],[3]]],
--   [[[3,1,2]],[[3,1,2]],[[3,2,1]],[[3,2,1]]],
--   [[[1],[2],[3]],[[3,1,2]],[[1],[2],[3]],[[3,2,1]]],
--   [[[3,1,2]],[[3,2,1]],[[3,2,1]],[[3,1,2]]], --
-- ]
