import Sandbox.SegmentIntersection (intersects, pointIsOnLine)
import Data.List (tails, permutations, nub)
import Helpers.Subsets (choose)

symmetrizeHalfChain m n points
  | odd (m * n) = error "odd"
  | otherwise   = points ++ reverse (map (rotate180 m n) points)

rotate180 m n (a, b) = (m + 1 - a, n + 1 - b)

type Point = (Integer, Integer)

intersectsPolygonalChain :: Point -> [Point] -> Bool
intersectsPolygonalChain _ [] = False
intersectsPolygonalChain x [p] = x == p
intersectsPolygonalChain x ps'@(p:ps) = pointIsOnLine x s || any (intersects (x, p)) segments where
  (s:segments) = ps' `zip` ps

isSelfIntersecting points = any (uncurry intersectsPolygonalChain) $ points `zip` tail (tails points)

f m n = nub $ map (canonical m n) $ filter (not . isSelfIntersecting) $ map (symmetrizeHalfChain m n) $ concatMap permutations $ choose (m*n `div` 2) [(a,b) | a <- [1..m], b <- [1..n]]

flipHorizontal m n = map f where
  f (a, b) = (m + 1 - a, b)

flipVertical m n = map f where
  f (a, b) = (a, n + 1 - b)

canonical m n points = minimum symmetries where
  symmetries = [points, flipVertical m n points, flipHorizontal m n points, flipVertical m n (flipHorizontal m n points)]
