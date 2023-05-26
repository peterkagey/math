import Data.List (delete, genericIndex, genericReplicate, genericTake, nub,  permutations,  sortOn,  tails)
import Data.Set (Set)
import qualified Data.Set as Set
import Helpers.SetHelpers (flatMap)
import Helpers.ListHelpers (cartesianProduct)
import qualified Data.MemoCombinators as Memo

type Base = [Integer]
type ConfigurationState = Set Base
newtype Strategy = Intermediate (Set (Base,  Strategy)) deriving (Show,  Eq,  Ord)

canonical :: Integer -> [Integer] -> [Integer]
canonical n l = minimum $ concatMap f $ necklaces l where
  f necklace = map incrementNecklace [1..n] where
    incrementNecklace i = map ((`mod` n) . (+i)) necklace

necklaces :: [Integer] -> [[Integer]]
necklaces l = map (take len) $ take len initialSegments where
  len = length l
  initialSegments = tails $ concat $ repeat l

-- This is slow and should be memoized.
configurationSum :: Integer -> [Integer] -> [Integer] -> Set [Integer]
configurationSum = Memo.memo3 Memo.integral (Memo.list Memo.integral) (Memo.list Memo.integral) configurationSum' where
  configurationSum' n c1 c2 = Set.fromList $ map (canonical n . zipWith (+) c1) $ necklaces c2

zero :: Integer -> [Integer]
zero n = genericReplicate n 0

initialStates :: Integer -> Set [Integer]
initialStates n = Set.delete (zero n) $ Set.fromList configurations where
  configurations = map (canonical n) $ cartesianProduct n [1..n]

addAll :: Integer -> Integer -> [Integer] -> Set [Integer] -> Set [Integer]
addAll n k configuration configurationState = Set.delete (zero (n^k)) $ flatMap (configurationSum n configuration) configurationState

-- nextGeneration :: Integer -> ConfigurationState -> [(Base,  ConfigurationState)]
-- -- map (\move -> (move,  addAll move nondeterministicState))
-- nextGeneration n configurationState = map (\move -> (move,  addAllN move configurationState)) moveList where
--   moveList = essentiallyUniqueStates n
--   addAllN = addAll n

-- essentiallyUniqueStates :: Integer -> [[Integer]]
-- essentiallyUniqueStates n = recurse [] (Set.toList $ initialStates n) where
--   f = configurationSum n
--   zero' = zero n
--   recurse known [] = known
--   recurse known (c:cs) = if essentiallyUnique then recurse (c:known) cs else recurse known cs where
--     essentiallyUnique = Set.notMember zero' $ flatMap (f c) $ Set.fromList known

-- strategy n = recurse (Set.singleton state) state where
--   state = initialStates n
--   ng = nextGeneration n
--   recurse :: Set ConfigurationState -> ConfigurationState -> Strategy
--   recurse knownStates currentGeneration
--     | Set.null currentGeneration = error "we're done!"
--     | otherwise                  = Intermediate $ Set.fromList iteration where
--     iteration = map (\(b,  nds) -> (b,  recurse newNondeterministicStates nds)) nextGen where
--       nextGen :: [(Base,  ConfigurationState)]
--       nextGen = filter ((`Set.notMember` knownStates) . snd) $ ng currentGeneration
--       newNondeterministicStates :: Set ConfigurationState
--       newNondeterministicStates = Set.union (Set.map snd $ Set.fromList nextGen) knownStates

-- This gives the switching strategy for C_p \wr C_p.
switchingStrategy :: Integer -> Integer -> [[Integer]]
switchingStrategy n k = recurse [] 1 where
  recurse strategy c
    | c == n^k  = strategy
    | otherwise = recurse newStrategy (c + 1) where
      newStrategy = (strategy ++) . concat . genericReplicate (n-1) $  move:strategy where
        move = genericTake (n^k) $ map (`mod` n) $ genericIndex pascalsDiagonals c

pascalsDiagonals :: [[Integer]]
pascalsDiagonals = recurse $ repeat 1 where
  recurse :: [Integer] -> [[Integer]]
  recurse l = l : recurse (scanl1 (+) l)

-- initialStates' :: Set Int
initialStates' n k = Set.delete (replicate n 0) $ Set.fromList configurations where
  configurations = map (canonical k) $ cartesianProduct n [1..k]
