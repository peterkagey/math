module KthDifferences.A999998 () where
import External.A174344 (a174344)
import Miscellaneous.A268038 (a268038)
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Maybe (Maybe, mapMaybe)
import Data.Ratio (Ratio, (%))

-- type KthDifferences = [((Integer, Integer), Set (Integer, Integer))]
type Point = (Integer, Integer)
data Slope = Vertical | Diagonal (Ratio Integer) deriving (Eq, Ord, Show)

type Status = (Point, Set Point, Set Slope)
-- Starting at (0,0) and using the spiral defined by A174344 and A268038, go to
-- the first value in (A174344(n), A268038(n)) such that the slope of all line
-- segments are distinct.

-- Each list of k-th differences distinct.
-- a999998_list :: [(Integer, Integer)]
a999998_list = (0,0) : recurse ((0,0), Set.singleton (0,0), Set.empty) where
  -- recurse kthDifferences = n : recurse ds where
  -- recurse kthDifferences = x : recurse ds where
  recurse status = p_0 : recurse status' where
    status'@(p_0, _, _) = nextDifferences status

-- a999998 :: Int -> (Integer, Integer)
-- a999998 n = a999998_list !! (n - 1)
--
nextDifferences :: Status -> Status
nextDifferences ds = head $ mapMaybe (`updateStatus` ds)  spiral
--   findNext (s, a, b) = fmap (\x-> (s,x)) $ (a, b) `updateDifferences` ds

spiral :: [Point]
spiral = map (\i -> (a174344 i, -a268038 i)) [1..]

-- nextTerm :: Status -> Point
-- spiral

updateStatus :: Point -> Status -> Maybe Status
updateStatus p_1 (p_0, points, slopes)
  | p_1 `Set.member` points = Nothing
  | otherwise = if slope `Set.member` slopes then Nothing else Just (p_1, points', slopes') where
    slope = slopeFrom p_0 p_1
    points' = p_1 `Set.insert` points
    slopes' = slope `Set.insert` slopes

slopeFrom (x_0, y_0) (x_1, y_1)
  | x_0 == x_1 = Vertical
  | otherwise  = Diagonal ((y_1 - y_0) % (x_1 - x_0))

-- updateDifferences :: (Integer, Integer) -> KthDifferences -> Maybe KthDifferences
-- updateDifferences nextTerm [] = Just [(nextTerm, Set.singleton nextTerm)]
-- updateDifferences nextTerm@(x,y) (((c,d), ds):ds')
--   | nextTerm `Set.member` ds = Nothing
--   | otherwise            = fmap (updated:) (updateDifferences (x-c, y-d) ds') where
--     updated = (nextTerm, Set.insert nextTerm ds)
