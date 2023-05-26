import Helpers.SetHelpers (flatMap)
import Data.Set (Set)
import qualified Data.Set as Set

type Permutation = [Int]

-- Permutation composition.
(*.*) a b = map (\j -> foldl (\i p -> p !! (i - 1)) j [a, b]) [1..length a]

generate :: [Permutation] -> Set Permutation
generate gs = recurse Set.empty $ Set.fromList gs where
  recurse knownTerms newTerms
    | Set.null newTerms = knownTerms
    | otherwise         = recurse knownTerms' newTerms' where
      nextGeneration = flatMap f newTerms where
        f t = Set.fromList $ map (*.* t) gs
        -- f t = Set.union (Set.fromList $ map (*.* t) gs) (Set.fromList $ map (t *.*) gs)
      knownTerms' = Set.union nextGeneration knownTerms
      newTerms'   = Set.difference nextGeneration knownTerms
