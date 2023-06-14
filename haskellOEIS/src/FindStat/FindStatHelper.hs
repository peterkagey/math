module FindStat.FindStatHelper (canonicalForm, fromWord, histogramRow) where
import Data.List (sort, permutations)
import qualified Data.Set as Set

type PermutationWord = [Int]
type CycleStructure = [[Int]]

histogramSorted :: [Int] -> [Int]
histogramSorted = recurse 0 0 where
  recurse _ c [] = [c]
  recurse i c as'@(a:as)
    | a == i = recurse i (c+1) as
    | a /= i = c : recurse (i+1) 0 as'

unpaddedHistogramRow :: ([Int] -> Int) -> Int -> [Int]
unpaddedHistogramRow st n = histogramSorted $ sort $ map st $ permutations [1..n]


histogramRow :: (Int, Int) -> ([Int] -> Int) -> Int -> [Int]
histogramRow (i_min, i_max) st n = drop i_min $ take (i_max + 1) $ unpaddedHistogramRow st n ++ repeat 0

canonicalForm :: CycleStructure -> CycleStructure
canonicalForm = sort . map smallestFirst where
  smallestFirst cyc = case span (> minValue) cyc of (x,y) -> y ++ x
    where
    minValue = minimum cyc

fromWord :: PermutationWord -> CycleStructure
fromWord p = canonicalForm $ recurse 1 [] (Set.fromList [1..length p]) where
  recurse x currentCycle unseen
    | null unseen           = [reverse currentCycle]
    | x `Set.member` unseen = recurse (p !! (x-1)) (x:currentCycle) (Set.delete x unseen)
    | otherwise             = reverse currentCycle : recurse (minimum unseen) [] unseen
