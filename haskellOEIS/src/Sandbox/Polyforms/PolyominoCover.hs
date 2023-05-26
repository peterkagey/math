module Sandbox.PolyominoCover (a999999) where
import Data.List (sort, nub, intersect)
-- https://codegolf.stackexchange.com/q/167484/53884

type Coord = Int
type Point = (Coord, Coord)
type Polyomino = [Point]

-- This is slow, and it can be sped up without too much trouble.
a999999 :: Int -> Int
a999999 n = head $ filter (anyCovering n) [n..]

connectionCount :: Polyomino -> Int
connectionCount [] = 0
connectionCount (p:ps) = length (intersect ps $ contiguous p) + connectionCount ps

-- https://rosettacode.org/wiki/Free_polyominoes_enumeration#Haskell
-- Finds the min x and y coordiate of a Polyomino.
minima :: Polyomino -> Point
minima (p:ps) = foldr (\(x, y) (mx, my) -> (min x mx, min y my)) p ps

translateToOrigin :: Polyomino -> Polyomino
translateToOrigin p =
    let (min_x, min_y) = minima p in
        map (\(x, y) -> (x - min_x, y - min_y)) p

rotate90, rotate180, rotate270, reflect :: Point -> Point
rotate90  (x, y) = ( y, -x)
rotate180 (x, y) = (-x, -y)
rotate270 (x, y) = (-y,  x)
reflect   (x, y) = (-x,  y)

-- All the plane symmetries of a rectangular region.
rotationsAndReflections :: Polyomino -> [Polyomino]
rotationsAndReflections p =
    [p,
     map rotate90 p,
     map rotate180 p,
     map rotate270 p,
     map reflect p,
     map (rotate90 . reflect) p,
     map (rotate180 . reflect) p,
     map (rotate270 . reflect) p]

canonical :: Polyomino -> Polyomino
canonical = minimum . map (sort . translateToOrigin) . rotationsAndReflections

-- All four points in Von Neumann neighborhood.
contiguous :: Point -> [Point]
contiguous (x, y) = [(x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)]

-- Finds all distinct points that can be added to a Polyomino.
newPoints :: Polyomino -> [Point]
newPoints p =
    let notInP = filter (not . flip elem p) in
        nub . notInP . concatMap contiguous $ p

newPolys :: Polyomino -> [Polyomino]
newPolys p = nub . map (canonical . flip (:) p) $ newPoints p

monomino = [(0, 0)]
monominoes = [monomino]

-- Generates polyominoes of rank n recursively.
rank :: Int -> [Polyomino]
rank 0 = []
rank 1 = monominoes
rank n = nub . concatMap newPolys $ rank (n - 1)

-- Generates a textual representation of a Polyomino.
textRepresentaton :: Polyomino -> String
textRepresentaton p =
    unlines [[if (x,y) `elem` p then '#' else ' ' | x <- [0 .. maxx - minx]]
             | y <- [0 .. maxy - miny]]
    where
        maxima :: Polyomino -> Point
        maxima (p:ps) = foldr (\(x, y) (mx, my) -> (max x mx, max y my)) p ps
        (minx, miny) = minima p
        (maxx, maxy) = maxima p

maxX :: Polyomino -> Coord
maxX polyomino = maximum $ map fst polyomino

maxY :: Polyomino -> Coord
maxY polyomino = maximum $ map snd polyomino
-- Check if a *fixed* polyomino fits in another polyomino.

translate :: Coord -> Coord -> Polyomino -> Polyomino
translate x y = map (\(a, b) -> (a + x, b + y))


covers :: Polyomino -> Polyomino -> Bool
covers largePolyomino smallPolyomino = any isCovering allTranslations where
  isCovering = all (`elem` largePolyomino)
  allTranslations = [translate x y smallPolyomino | x <- [0..xDifference], y <- [0..yDifference]] where
    xDifference = maxX largePolyomino - maxX smallPolyomino
    yDifference = maxY largePolyomino - maxY smallPolyomino

anySymmetryIsCoveredBy :: Polyomino -> Polyomino -> Bool
anySymmetryIsCoveredBy smallPolyomino largePolyomino = any (largePolyomino `covers`) symmetries where
  symmetries = map (sort . translateToOrigin) $ rotationsAndReflections smallPolyomino

coversAll :: Polyomino -> [Polyomino] -> Bool
coversAll largePolyomino = all (`anySymmetryIsCoveredBy` largePolyomino)

anyCovering :: Int -> Int -> Bool
anyCovering n a_n
  | n > a_n = False
  | otherwise = any (`coversAll` smallPolyominoes) $ rank a_n where
    smallPolyominoes = rank n

----------------------------------
allMax :: (a -> Int) -> [a] -> [a]
allMax _ []     = []
allMax f (a:as) = recurse [a] (f a) as where
  recurse known _ []  = known
  recurse known knownMax (x:xs)
    | f x == knownMax = recurse (x : known) knownMax xs
    | f x < knownMax  = recurse       known knownMax xs
    | otherwise       = recurse         [x]    (f x) xs

-- coveringPolyominoes :: Int -> Int -> [Polyomino]
-- coveringPolyominoes smallSize largeSize = filter coversAll (rank largeSize) where
--   smallPolyominoes = rank smallSize
--   coversAll polyomino = all (`anySymmetryIsCoveredBy` polyomino) smallPolyominoes
--
-- coveringCount :: Polyomino -> [Polyomino] -> Int
-- coveringCount coveringCandidate smallPolyominoes = length $ filter (`anySymmetryIsCoveredBy` coveringCandidate) smallPolyominoes
--
-- smallishCoveringPolyominoes :: Int -> [Polyomino]
-- smallishCoveringPolyominoes n = recurse [seed] where
--   allSmallPolyominoes = rank n
--   smallPolyominoCount = length allSmallPolyominoes
--   seed = map (\i -> (0, i)) [0..n-1]
--   recurse polyominoes
--     | numberCovering == smallPolyominoCount = polyominoes
--     | otherwise                             = recurse nextGeneration where
--     numberCovering = head polyominoes `coveringCount` allSmallPolyominoes
--     nextGeneration = buildNextGeneration allSmallPolyominoes polyominoes
--
-- buildNextGeneration :: [Polyomino] -> [Polyomino] -> [Polyomino]
-- buildNextGeneration smallPolyominoes candidatePolyominoes = newCandidates `withMaximumOverlap` (`coveringCount` smallPolyominoes) where
--   newCandidates = nub . concatMap newPolys $ candidatePolyominoes
--
-- withMaximumOverlap :: [Polyomino] -> (Polyomino -> Int) -> [Polyomino]
-- withMaximumOverlap [] _ = []
-- withMaximumOverlap (p:ps) f = recurse [p] ps (f p) where
--   recurse candidates [] _ = candidates
--   recurse candidates (r:rs) value
--     | f r > value = recurse [r] rs (f r)
--     | f r == value = recurse (r:candidates) rs value
--     | otherwise = recurse candidates rs value

-- a(6) = 12
-- #
-- ####
-- ######
--   #

-- a(7) <= 17
-- #
-- #####
-- #######
--  ###
--   #

-- a(8) <= 22
--   ##
-- ####
--   ###
--   ###
--  #####
--    ##
--    #
--   ##

-- a(9) <= 26
--   #####
-- #########
-- #######
--  ###
--   ##


-- a(10) <= 32
--  ###
-- #####
-- #####
-- #####
-- ### #
-- ###
-- ###
--  #
--  #
--  ##
