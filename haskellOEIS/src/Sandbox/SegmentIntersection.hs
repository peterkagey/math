module Sandbox.SegmentIntersection (intersects, pointIsOnLine) where
import Data.Ratio ((%))

type Point = (Integer, Integer)
type LineSegment = (Point, Point)

intersects :: LineSegment -> LineSegment -> Bool
intersects ls@(p1@(x1, y1), p2@(x2, y2)) ls'@(p3@(x3, y3), p4@(x4, y4))
  | isParallel ls ls' = pointIsOnLine p3 ls || pointIsOnLine p4 ls
  | otherwise = 0 <= min t s && max t s <= 1 where
    y' = y2 - y1
    x' = x2 - x1
    x'' = x4 - x3
    y'' = y4 - y3
    s = (y' * (x1 - x3) + x' * (y3 - y1)) % (y' * x'' - x' * y'')
    t = (y'' * (x1 - x3) + x'' * (y3 - y1)) % (y' * x'' - x' * y'')

isParallel :: LineSegment -> LineSegment -> Bool
isParallel ((x1, y1), (x2, y2)) ((x3, y3), (x4, y4)) = (x2 - x1)*(y3 - y4) == (x3 - x4)*(y2 - y1)

pointIsOnLine :: Point -> LineSegment -> Bool
pointIsOnLine p@(x,y) (p1@(x1, y1), p2@(x2, y2))
  | p1 == p2  = p == p1
  | x1 == x2  = x == x1 && min y1 y2 <= y && y <= max y1 y2
  | y1 == y2  = y == y1 && min x1 x2 <= x && x <= max x1 x2
  | otherwise = t == t' && 0 <= t && t <= 1 where
    t  = (x - x1) % (x2 - x1)
    t' = (y - y1) % (y2 - y1)
