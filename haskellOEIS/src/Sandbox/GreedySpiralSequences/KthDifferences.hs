module KthDifferences.A999999 (a999999_list, a999999) where
import External.A174344 (a174344)
import Miscellaneous.A268038 (a268038)
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Maybe (Maybe, mapMaybe)

type KthDifferences = [((Integer, Integer), Set (Integer, Integer))]

-- Starting at (0,0) and using the spiral defined by A174344 and A268038, go to
-- the first value in (A174344(n), A268038(n)) such that all k-th differences
-- are distinct.

-- Each list of k-th differences distinct.
-- a999999_list :: [(Integer, Integer)]
a999999_list = recurse [] where
  -- recurse kthDifferences = n : recurse ds where
  -- recurse kthDifferences = x : recurse ds where
  recurse kthDifferences = y : recurse ds where
    (n, ds@(((x,y),_):_)) = nextDifferences kthDifferences

-- a999999 :: Int -> (Integer, Integer)
a999999 n = a999999_list !! (n - 1)

nextDifferences :: KthDifferences -> (Int, KthDifferences)
nextDifferences ds = head $ mapMaybe findNext spiral where
  findNext (s, a, b) = fmap (\x-> (s,x)) $ (a, b) `updateDifferences` ds

spiral :: [(Int, Integer, Integer)]
spiral = map (\i -> (i, a174344 i, -a268038 i)) [1..]

updateDifferences :: (Integer, Integer) -> KthDifferences -> Maybe KthDifferences
updateDifferences nextTerm [] = Just [(nextTerm, Set.singleton nextTerm)]
updateDifferences nextTerm@(x,y) (((c,d), ds):ds')
  | nextTerm `Set.member` ds = Nothing
  | otherwise            = fmap (updated:) (updateDifferences (x-c, y-d) ds') where
    updated = (nextTerm, Set.insert nextTerm ds)
