import Data.Set (Set)
import qualified Data.Set as Set
import Data.List (nub, sort)
import Helpers.ListHelpers (cartesianProduct)
-- Number of equivalence classes for $n$-sided coins on the $n$-gon.
-- A130293

canonical n configuration = minimum $ concatMap necklace $ increment n configuration

necklace configuration = map (\i -> take len $ drop i loop) [0..len-1] where
  loop = cycle configuration
  len = length configuration

increment n configuration = map bump [0..n-1] where
  bump i = map (\c -> (c + i) `mod` n) configuration

losingStates n = foldr (insertStandardized n) Set.empty $ cartesianProduct n [1..n]

insertStandardized n configuration set
  | all (==0) configuration' = set
  | otherwise                = Set.insert configuration' set where
    configuration' = canonical n configuration

-- -- strategy n = recurse [] [moves] where
--   -- moves = losingStates n
--   -- recurse pastGenerations currentGeneration =

nextGeneration n configuration = foldr f Set.empty where
  f old = insertStandardized n (zipWith (+) old configuration)

-- Memoize this?
offSpring n c1 c2 = foldr insertSum Set.empty (necklace c1) where
  insertSum c1' = insertStandardized n (zipWith (+) c1' c2)
