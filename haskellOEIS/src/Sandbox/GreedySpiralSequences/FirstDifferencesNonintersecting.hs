module KthDifferences.A999996 () where
import External.A174344 (a174344)
import Miscellaneous.A268038 (a268038)
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Maybe (Maybe, mapMaybe)
import Data.Ratio (Ratio, (%))
import Sandbox.SegmentIntersection (intersects, pointIsOnLine)

-- type KthDifferences = [((Integer, Integer), Set (Integer, Integer))]
type Point = (Integer, Integer)

type Status = (Point, [Point], Set (Integer, Integer))
-- Starting at (0,0) and using the spiral defined by A174344 and A268038, go to
-- the first value in (A174344(n), A268038(n)) such that the polygonal chain
-- does not self-intersect and all first differences are distinct.

-- Each list of k-th differences distinct.
-- a999996_list :: [(Integer, Integer)]
a999996_list = (0,0) : recurse ((0,0), [(0,0)], Set.empty) where
  -- recurse kthDifferences = n : recurse ds where
  -- recurse kthDifferences = x : recurse ds where
  recurse status = p_0 : recurse status' where
    status'@(p_0, _, _) = nextDifferences status
--
-- -- a999996 :: Int -> (Integer, Integer)
-- -- a999996 n = a999996_list !! (n - 1)
-- --
nextDifferences :: Status -> Status
nextDifferences ds = head $ mapMaybe (`updateStatus` ds) spiral
--   findNext (s, a, b) = fmap (\x-> (s,x)) $ (a, b) `updateDifferences` ds
--
spiral :: [Point]
spiral = map (\i -> (a174344 i, -a268038 i)) [1..]
--
updateStatus :: Point -> Status -> Maybe Status
updateStatus p_1 (p_0, points@(point:_), firstDifferences)
  | p_1 `elem` points                   = Nothing
  | intersectsPolygonalChain p_1 points = Nothing
  | fd `Set.member` firstDifferences        = Nothing
  | otherwise                           = Just (p_1, p_1:points, firstDifferences') where
    fd = firstDiff p_0 p_1
    firstDifferences' = fd `Set.insert` firstDifferences

firstDiff :: Point -> Point -> (Integer, Integer)
firstDiff (x0, y0) (x1, y1) = (x0 - x1, y0 - y1)

intersectsPolygonalChain :: Point -> [Point] -> Bool
intersectsPolygonalChain _ [] = False
intersectsPolygonalChain x [p] = x == p
intersectsPolygonalChain x ps'@(p:ps) = pointIsOnLine x s || any (intersects (x, p)) segments where
  (s:segments) = ps' `zip` ps
