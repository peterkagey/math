module Sandbox.GridTiles.Rotation (D8(..)) where
import Sandbox.GridTiles.SquareGridTiles (Tile(..), D8(..), transformTile)
import Sandbox.GridTiles.SquareGridPrintingBeta (printTori, printGrids)
import qualified Data.Map.Strict as Map
import qualified Data.Set as Set
import Control.Monad (replicateM)

type Tiling = Map.Map (Int, Int) Tile

bimap :: Ord k' => (k -> v -> (k', v')) -> Map.Map k v -> Map.Map k' v'
bimap f = Map.fromList . map (uncurry f) . Map.toList

transform :: Int -> D8 -> Tiling -> Tiling
transform n H = bimap (\(x, y) t -> ((n - x - 1, y),         transformTile H t))
transform n V = bimap (\(x, y) t -> ((x, n - y - 1),         transformTile V t))
transform n D = bimap (\(x, y) t -> ((y, x),                 transformTile D t))
transform n A = bimap (\(x, y) t -> ((n - y - 1, n - x - 1), transformTile A t))
transform n I = id
transform n P = transform n H . transform n D
transform n R = transform n P . transform n P
transform n N = transform n P . transform n R

shift :: Int -> (Int, Int) -> Tiling -> Tiling
shift n (i,j) = Map.mapKeys (\(x, y) -> ((x+i) `mod` n, (y+j) `mod` n))

canonicalGrid :: Int -> [D8] -> Tiling -> Tiling
canonicalGrid n symmetries tiling = minimum $ transformations where
  transformations = [transform n g tiling | g <- symmetries]

canonicalTorus :: Int -> [D8] -> Tiling -> Tiling
canonicalTorus n symmetries tiling = minimum $ transformations where
  transformations = [shift n (x, y) $ transform n g tiling | g <- symmetries, x <- [0..n-1], y <- [0..n-1]]

rawGrids tiles n = map (Map.fromList . zip keys) allPatterns where
  allPatterns = replicateM (n^2) tiles
  keys = [(x, y) | x <- [0..n-1], y <- [0..n-1]]

allSquareGridsUpTo :: [D8] -> [Tile] -> Int -> Set.Set Tiling
allSquareGridsUpTo symmetries tiles n = Set.fromList $ map (canonicalGrid n symmetries) $ rawGrids tiles n

allSquareToriUpTo :: [D8] -> [Tile] -> Int -> Set.Set Tiling
allSquareToriUpTo symmetries tiles n = Set.fromList $ map (canonicalTorus n symmetries) $ rawGrids tiles n

printSquareToriUpTo symmetries tiles n = (printTori n) $ Set.toList $ allSquareToriUpTo symmetries tiles n
printSquareGridsUpTo symmetries tiles n = printGrids $ Set.toList $ allSquareGridsUpTo symmetries tiles n

countSquareToriUpTo symmetries tiles n = Set.size $ allSquareToriUpTo symmetries tiles n
countSquareGridsUpTo symmetries tiles n = Set.size $ allSquareGridsUpTo symmetries tiles n

-- countTilings [TileZ, TileS, TileH, TileN] 1
-- 1
-- countTilings [TileZ, TileS, TileH, TileN] 2
-- 23
-- countTilings [TileZ, TileS, TileH, TileN] 3
-- 3776
