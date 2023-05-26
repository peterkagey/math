import Helpers.ConvexHull (convexHull)
import Data.List (nub, (\\))
-- Create a walk of steps sqrt(1), sqrt(4), sqrt(5), sqrt(8), sqrt(9), sqrt(10), sqrt(12)
-- minimizing the perimeter of the convexHull.

-- Slow, but it works for now.
stepsOfLengthSqrtN :: Int -> [(Int, Int)]
stepsOfLengthSqrtN n = filter (\(a, b) -> a^2 + b^2 == n) [(a, b) | a <- [0..n], b <- [a..n]]

planeFigureSeq :: [(Int, Int)]
planeFigureSeq = (0, 0) : (1, 0) : (0, 1) : recurse 3 where
  recurse :: Int -> [(Int, Int)]
  recurse n = nextTerm : recurse (n + 1) where
    knownTerms = take n planeFigureSeq
    currentPosition = planeFigureSeq !! (n - 1)
    nextTerm :: (Int, Int)
    nextTerm = minByUniq (perimeter . (:knownTerms)) validPossibleSteps where
      possibleSteps = nextSteps currentPosition $ stepsOfLengthSqrtN $ a001481 (n + 1)
      validPossibleSteps = possibleSteps \\ knownTerms

perimeter :: [(Int, Int)] -> Float
perimeter ps@(p:_) = computePerimeter $ convexHull ps where
  computePerimeter [] = 0
  computePerimeter [a] = 0
  computePerimeter [a, b] = dist a b
  computePerimeter ps = dist (head ps) (last ps) + adj where
    adj = sum $ zipWith dist ps $ tail ps

dist :: (Int, Int) -> (Int, Int) -> Float
dist (x_1, y_1) (x_2, y_2) = sqrt $ fromIntegral $ (x_1 - x_2)^2 + (y_1 - y_2)^2

steps :: (Int, Int) -> (Int, Int) -> [(Int, Int)]
steps (a, b) (0, y) = [(a + y, b), (a - y, b), (a, b + y), (a, b - y)]
steps (a, b) (x, y) = [(a + x, b + y), (a + x, b - y), (a - x, b + y), (a - x, b - y), (a + y, b + x), (a + y, b - x), (a - y, b + x), (a - y, b - x)]

nextSteps :: (Int, Int) -> [(Int, Int)] -> [(Int, Int)]
nextSteps currentPosition = nub . concatMap (steps currentPosition)
-- A001481 1 = 0
-- A001481 2 = 1
-- A001481 3 = 2
-- A001481 4 = 4
-- A001481 5 = 5
-- A001481 6 = 8
-- A001481 7 = 9
-- A001481 8 = 10
-- A001481 9 = 13

a001481_list = filter (not . null . stepsOfLengthSqrtN ) [0..]

a001481 n = a001481_list !! (n - 1)

-- Find minimum, but only if there's only one minimum.
minByUniq :: (Show a, Ord b) => (a -> b) -> [a] -> a
minByUniq f (a:as) = recurse [a] as where
  recurse [knownMin] [] = knownMin
  recurse (x:x':xs) [] = error $ show (x, x')
  recurse ms@(m:_) (x:xs)
    | f m  < f x = recurse ms xs
    | f m == f x = recurse (x:ms) xs
    | f m  > f x = recurse [x] xs
