import Data.List (nub, subsequences, map)
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Map (Map, fromSet, (!))

type State = Set Int
type Flips = Set Int
type GraphState = Set State
type M = Map State State -- Map that sends states to their canonical representation

-- Maybe use compositions instead of subsets to represent the different states? Then n is implicit.

canonicalStateMap :: Int -> Set State -> M
canonicalStateMap n = fromSet (canonicalState n)

allStates :: Int -> Set State
allStates n = Set.fromList $ Data.List.map Set.fromList $ subsequences [0..n-1]

startingState :: Map State State -> Set State -> Set State
startingState m = Data.Set.map (m !)

canonicalState :: Int -> State -> State
canonicalState n xs = minimum $ concatMap (\as -> [as, complement n as]) $ foldr prependShifted [xs] [1..n] where
  prependShifted _ as@(a:_) = shiftSet n a : as

complement :: Int -> State -> State
complement n s = Set.fromList [0..n-1] \\ s

shiftSet :: Int -> State -> State
shiftSet n = Data.Set.map (\i -> (i + 1) `mod` n)

nextGraphState :: [Move] -> GraphState -> GraphState
nextGraphState moves currentState = foldr union Data.Set.empty allMoves where
  allMoves = Data.List.map (`doMove` currentState) moves

-- Make canonical
doMove :: Move -> GraphState -> GraphState
doMove move = Data.Set.map (move -|-)

(-|-) :: Ord a => Set a -> Set a -> Set a
x -|- y = (x \\ y) `union` (y \\ x)

-- isPossible :: Int -> Bool
-- isPossible n = recurse [startingState] where
--   states = allStates n
--   stateMap = canonicalStateMap n states
--   startingState = startingState stateMap states
--   recurse graphStates = where
--     nextState =

-- nextGraphState :: Map State State -> Set State -> GraphState -> GraphState
-- nextGraphState canonicalLookup everyState graphState = foldr () Set.empty graphState
