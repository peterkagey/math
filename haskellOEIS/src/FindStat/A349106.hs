module FindStat.A349106 (a349106) where
import Data.List (sort, permutations)
import Data.Set (Set)
import qualified Data.Set as Set

type CycleStructure = [[Int]]

fromWord p = canonicalForm' $ recurse 1 [] (Set.fromList [1..length p]) where
  recurse x currentCycle unseen
    | null unseen           = [reverse currentCycle]
    | x `Set.member` unseen = recurse (p !! (x-1)) (x:currentCycle) (Set.delete x unseen)
    | otherwise             = reverse currentCycle : recurse (minimum unseen) [] unseen

canonicalForm' :: CycleStructure -> CycleStructure
canonicalForm' = sort . map smallestFirst where
  smallestFirst permutationCycle = case span (> minValue) permutationCycle of
                                                                            (x,y) -> y ++ x
    where
    minValue = minimum permutationCycle

-- map st000317 $ Data.List.permutations [1,2,3,4,5,6]

-- Assumes input is sorted.
histogramSorted :: [Int] -> [Int]
histogramSorted = recurse 0 0 where
  recurse _ c [] = [c]
  recurse i c as'@(a:as)
    | a == i = recurse i (c+1) as
    | a /= i = c : recurse (i+1) 0 as'

st000317 w = sum $ map (\c -> length $ filter (uncurry (>)) $ zip c (tail c)) $ fromWord w

a349106_row n = histogramSorted $ sort $ map st000317 $ permutations [1..n]

a349106_list = concatMap a349106_row [0..]

a349106 n = a349106_list !! n
