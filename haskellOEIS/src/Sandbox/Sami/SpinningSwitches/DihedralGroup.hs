import Helpers.ListHelpers (cartesianProduct)
import Data.List (delete, nub)
import Data.Set (Set)
import qualified Data.Set as Set
import Helpers.SetHelpers (flatMap)

-- Dihedral group of the square
-- `Unflipped n` is r^n
-- `Flipped n` is fr^n
data DihedralElement = Unflipped Int | Flipped Int deriving (Show, Eq, Ord)
type Base = (DihedralElement, DihedralElement)
type NondeterministicState = Set Base
newtype Strategy = Intermediate (Set (Base, Strategy)) deriving (Show, Eq, Ord)
groupMultiplication :: DihedralElement -> DihedralElement -> DihedralElement
groupMultiplication (Unflipped n) (Unflipped m) = Unflipped ((n + m) `mod` 4)
groupMultiplication (Flipped n)   (Unflipped m) = Flipped   ((n + m) `mod` 4)
groupMultiplication (Unflipped n) (Flipped m)   = Flipped   ((m - n) `mod` 4)
groupMultiplication (Flipped n)   (Flipped m)   = Unflipped ((m - n) `mod` 4)

(@@) = groupMultiplication

allStates = [Unflipped n | n <- [0..3]] ++ [Flipped n | n <- [0..3]]

-------------------
-- Now assume we have two squares, but we might swap the order of them.
canonical (a, b) = minimum $ [(s@@a, s@@b) | s <- allStates] ++ [(s@@b, s@@a) | s <- allStates]

intermediateEquivalenceClasses :: Set Base
intermediateEquivalenceClasses = Set.delete (Unflipped 0,Unflipped 0) $ Set.fromList [canonical (x, y) | x <- allStates, y <- allStates]

blindFoldedMultiplication :: Base -> Base -> Set Base
blindFoldedMultiplication (a, b) (x, y) = Set.fromList [canonical (a @@ x, b @@ y), canonical (b @@ x, a @@ y)]

-- Take a move, and apply it to the nondeterministic state
addAll :: Base -> NondeterministicState -> NondeterministicState
addAll move nondeterministicState = Set.delete (Unflipped 0,Unflipped 0) $ flatMap (blindFoldedMultiplication move) nondeterministicState

-- nextGeneration :: Set Base -> Set (Set Base)
-- nextGeneration states = Set.map (`addAll` states) intermediateEquivalenceClasses

nextGeneration :: NondeterministicState -> [(Base, NondeterministicState)]
nextGeneration nondeterministicState = map (\move -> (move, addAll move nondeterministicState)) moveList where
  moveList = Set.toList intermediateEquivalenceClasses

strategy = recurse (Set.singleton state) state where
  state = intermediateEquivalenceClasses
  recurse :: Set NondeterministicState -> NondeterministicState -> Strategy
  recurse knownStates currentGeneration
    | Set.null currentGeneration = error "we're done!"
    | otherwise                  = Intermediate $ Set.fromList iteration where
    iteration = map (\(b, nds) -> (b, recurse newNondeterministicStates nds)) nextGen where
      nextGen :: [(Base, NondeterministicState)]
      nextGen = filter ((`Set.notMember` knownStates) . snd) $ nextGeneration currentGeneration
      newNondeterministicStates :: Set NondeterministicState
      newNondeterministicStates = Set.union (Set.map snd $ Set.fromList nextGen) knownStates

-- -- data Strategy = Intermediate DihedralElement (Set Strategy) | FinalStep deriving (Show, Eq, Ord)
-- strategy = recurse (Set.singleton states) (Set.singleton states) where
--   states = intermediateEquivalenceClasses
--   recurse :: Set (Set Base) -> Set (Set Base) -> Strategy
--   recurse allKnown currentGeneration
--     | Set.null currentGeneration             = error $ show allKnown
--     | Set.member Set.empty currentGeneration = True
--     | otherwise                              = recurse (Set.union allKnown nextGen) nextGen where
--     nextGen = Set.difference (flatMap nextGeneration currentGeneration) allKnown
