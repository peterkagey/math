import Data.List (permutations, tails, nub, delete)
import Data.Set (Set)
import qualified Data.Set as Set
import Helpers.SetHelpers (flatMap)
import Helpers.ListHelpers (cartesianProduct)
import qualified Data.MemoCombinators as Memo

type ConfigurationState = Set [Int]

canonical :: Int -> [Int] -> [Int]
canonical n l = minimum $ concatMap f $ necklaces l where
  f necklace = map incrementNecklace [1..n] where
    incrementNecklace i = map ((`mod` n) . (+i)) necklace

necklaces :: [Int] -> [[Int]]
necklaces l = map (take len) $ take len initialSegments where
  len = length l
  initialSegments = tails $ concat $ repeat l

-- This is slow and should be memoized.
configurationSum :: Int -> [Int] -> [Int] -> Set [Int]
configurationSum = Memo.memo3 Memo.integral (Memo.list Memo.integral) (Memo.list Memo.integral) configurationSum' where
  configurationSum' n c1 c2 = Set.fromList $ map (canonical n . zipWith (+) c1) $ necklaces c2

initialStates = Set.delete [0,0,0,0,0] . Set.fromList . configurations where
  configurations n = map (canonical n) $ cartesianProduct n [1..n]

addAll :: Int -> [Int] -> Set [Int] -> Set [Int]
addAll n configuration configurationState = Set.delete (replicate n 0) $ flatMap (configurationSum n configuration) configurationState

nextGeneration :: Int -> ConfigurationState -> Set ConfigurationState
nextGeneration n configurationState = Set.map (`addAllN` configurationState) $ initialStates n where
  addAllN = addAll n

nextGeneration5 :: ConfigurationState -> Set ConfigurationState
nextGeneration5 = nextGeneration 5

flippable :: Int -> Bool
flippable n = recurse (Set.singleton states) (Set.singleton states) where
  states = initialStates n
  recurse allKnown currentGeneration
    | Set.null currentGeneration             = error $ show allKnown
    | Set.member Set.empty currentGeneration = True
    | otherwise                              = recurse (Set.union allKnown nextGen) nextGen where
    nextGen = Set.difference (flatMap (nextGeneration n) currentGeneration) allKnown
