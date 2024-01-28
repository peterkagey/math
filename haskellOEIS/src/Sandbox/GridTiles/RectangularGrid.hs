module Sandbox.GridTiles.Rotation (V(..)) where
import Sandbox.GridTiles.RectangularGridTiles (Tile(..), V(..), transformTile)
import Sandbox.GridTiles.RectangularGridPrintingBeta (printGrids, printCylinders, printTori)
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set
import Control.Monad (replicateM)
import Data.List (nub, intercalate)
import Text.Printf

type Tiling = Map.Map (Int, Int) Tile

bimap :: Ord k' => (k -> v -> (k', v')) -> Map.Map k v -> Map.Map k' v'
bimap f = Map.fromList . map (uncurry f) . Map.toList

transform :: Int -> Int -> V -> Tiling -> Tiling
transform n _ H = bimap (\(x, y) t -> ((n - x - 1, y), transformTile H t))
transform _ m V = bimap (\(x, y) t -> ((x, m - y - 1), transformTile V t))
transform _ _ I = id
transform n m R = transform n m H . transform n m V

allTilings :: [Tile] -> Int -> Int -> [Tiling]
allTilings tiles n m = map (Map.fromList . zip keys) allPatterns where
  allPatterns = replicateM (n*m) tiles
  keys = [(x, y) | x <- [0..n-1], y <- [0..m-1]]

shiftCylinder :: Int -> Int -> Tiling -> Tiling
shiftCylinder n i = Map.mapKeys (\(x, y) -> ((x+i) `mod` n, y))

shiftTorus :: Int -> Int -> Int -> Int -> Tiling -> Tiling
shiftTorus n m i j = Map.mapKeys (\(x, y) -> ((x+i) `mod` n, (y+j) `mod` m))

canonicalGrid :: [V] -> Int -> Int -> Tiling -> Tiling
canonicalGrid subgroup n m tiling = minimum $ transformations where
  transformations = [transform n m g tiling | g <- subgroup]

canonicalCylinder :: [V] -> Int -> Int -> Tiling -> Tiling
canonicalCylinder subgroup n m tiling = minimum $ transformations where
  transformations = [transform n m g $ shiftCylinder n i tiling | g <- subgroup, i <- [0..n-1]]

canonicalTorus :: [V] -> Int -> Int -> Tiling -> Tiling
canonicalTorus subgroup n m tiling = minimum $ transformations where
  transformations = [transform n m g $ shiftTorus n m i j tiling | g <- subgroup, i <- [0..n-1], j <- [0..m-1]]

allGridsUpTo :: [V] -> [Tile] -> Int -> Int -> Set.Set Tiling
allGridsUpTo symmetries tiles n m = Set.fromList $ map (canonicalGrid symmetries n m) $ allTilings tiles n m

allCylindersUpTo :: [V] -> [Tile] -> Int -> Int -> Set.Set Tiling
allCylindersUpTo symmetries tiles n m = Set.fromList $ map (canonicalCylinder symmetries n m) $ allTilings tiles n m

allToriUpTo :: [V] -> [Tile] -> Int -> Int -> Set.Set Tiling
allToriUpTo symmetries tiles n m = Set.fromList $ map (canonicalTorus symmetries n m) $ allTilings tiles n m

-- I = Identity
-- P = +90º rotation
-- R = 180° rotation
-- N = -90º rotation
-- H = Horizontal flip
-- V = Vertical flip
-- D = Diagonal flip
-- A = Antidiagonal flip

printCylindersUpTo symmetries tiles n m = (printCylinders n) $ Set.toList $ allCylindersUpTo symmetries tiles n m

printToriUpTo symmetries tiles n m = (printTori n m) $ Set.toList $ allToriUpTo symmetries tiles n m

printGridsUpTo symmetries tiles n m = printGrids $ Set.toList $ allGridsUpTo symmetries tiles n m

countCylindersUpTo symmetries tiles n m = Set.size $ allCylindersUpTo symmetries tiles n m

countToriUpTo symmetries tiles n m = Set.size $ allToriUpTo symmetries tiles n m

countGridsUpTo symmetries tiles n m = Set.size $ allGridsUpTo symmetries tiles n m
