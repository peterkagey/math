module Sandbox.GridTiles.Rotation (D8(..)) where
import qualified Data.Map.Strict as Map
import Control.Monad (replicateM)
type C4Tiling = Map.Map (Int, Int) C4Tile
type Rot180Tiling = Map.Map (Int, Int) Rot180Tile
type HTiling = Map.Map (Int, Int) HTile

-- I = Identity
-- P = +90º rotation
-- R = 180° rotation
-- N = -90º rotation
-- H = Horizontal flip
-- V = Vertical flip
-- D = Diagonal flip
-- A = Antidiagonal flip
data D8 = I | P | R | N | H | V | D | A deriving (Eq)

-- Tile with 90° rotational symmetry
-- Stable under <P> ~= C4
data C4Tile = TileCW | TileCCW deriving (Eq, Show, Ord)

-- Tile with 180° rotational symmetry
-- Stable under <R> = <P^2> ~= C2
data Rot180Tile = TileZ | TileS | TileH | TileN deriving (Eq, Show, Ord)
--                ⇄       ⇆       ⇵       ⇅

data HTile = TileU | TileD | TileL | TileR deriving (Eq, Show, Ord)
--           ⇈       ⇊	     ⇇       ⇉

flipC4Tile :: C4Tile -> C4Tile
flipC4Tile TileCW  = TileCCW
flipC4Tile TileCCW = TileCW

transformRot180Tile :: D8 -> Rot180Tile -> Rot180Tile
transformRot180Tile I t     = t
transformRot180Tile R t     = t
transformRot180Tile H TileZ = TileS
transformRot180Tile H TileS = TileZ
transformRot180Tile H TileH = TileN
transformRot180Tile H TileN = TileH
transformRot180Tile P TileZ = TileN
transformRot180Tile P TileS = TileH
transformRot180Tile P TileH = TileS
transformRot180Tile P TileN = TileZ
transformRot180Tile N t     = transformRot180Tile P t
transformRot180Tile V t     = transformRot180Tile H t
transformRot180Tile D t     = transformRot180Tile P $ transformRot180Tile H t
transformRot180Tile A t     = transformRot180Tile P $ transformRot180Tile H t

transformHTile :: D8 -> HTile -> HTile
transformHTile P TileU = TileL
transformHTile P TileD = TileR
transformHTile P TileL = TileD
transformHTile P TileR = TileU
transformHTile H TileU = TileU
transformHTile H TileD = TileD
transformHTile H TileL = TileR
transformHTile H TileR = TileL
transformHTile I t     = t
transformHTile R t     = transformHTile P $ transformHTile P t
transformHTile N t     = transformHTile P $ transformHTile R t
transformHTile V t     = transformHTile R $ transformHTile H t
transformHTile D t     = transformHTile N $ transformHTile H t
transformHTile A t     = transformHTile P $ transformHTile H t



bimap :: Ord k' => (k -> v -> (k', v')) -> Map.Map k v -> Map.Map k' v'
bimap f = Map.fromList . map (uncurry f) . Map.toList

-- Count tilings on the n x n grid --
transform :: Int -> D8 -> C4Tiling -> C4Tiling
transform n I = id
transform n H = bimap (\(x, y) t -> ((n - x + 1, y), flipC4Tile t))
transform n V = bimap (\(x, y) t -> ((x, n - y + 1), flipC4Tile t))
transform n D = bimap (\(x, y) t -> ((y, x), flipC4Tile t))
transform n A = bimap (\(x, y) t -> ((n - y + 1, n - x + 1), flipC4Tile t))
transform n P = transform n H . transform n D
transform n R = transform n P . transform n P
transform n N = transform n P . transform n R

-- Count tilings on the n x n grid --
-- Rot180
transform' :: Int -> D8 -> Rot180Tiling -> Rot180Tiling
transform' n I = id
transform' n H = bimap (\(x, y) t -> ((n - x + 1, y),         transformRot180Tile H t))
transform' n V = bimap (\(x, y) t -> ((x, n - y + 1),         transformRot180Tile V t))
transform' n D = bimap (\(x, y) t -> ((y, x),                 transformRot180Tile D t))
transform' n A = bimap (\(x, y) t -> ((n - y + 1, n - x + 1), transformRot180Tile A t))
transform' n P = transform' n H . transform' n D
transform' n R = transform' n P . transform' n P
transform' n N = transform' n P . transform' n R

transform'' :: Int -> D8 -> HTiling -> HTiling
transform'' n I = id
transform'' n H = bimap (\(x, y) t -> ((n - x + 1, y),         transformHTile H t))
transform'' n V = bimap (\(x, y) t -> ((x, n - y + 1),         transformHTile V t))
transform'' n D = bimap (\(x, y) t -> ((y, x),                 transformHTile D t))
transform'' n A = bimap (\(x, y) t -> ((n - y + 1, n - x + 1), transformHTile A t))
transform'' n P = transform'' n H . transform'' n D
transform'' n R = transform'' n P . transform'' n P
transform'' n N = transform'' n P . transform'' n R

-- canonical :: Int -> C4Tiling -> C4Tiling
canonical n tiling = minimum $ map (\t -> t tiling) transformations where
  transformations = map (transform n) [I, P, R, N, H, V, D, A]

allTilings n = map (Map.fromList . zip keys) allPatterns where
  allPatterns = replicateM (n^2) [TileCW, TileCCW]
  keys = [(x, y) | x <- [1..n], y <- [1..n]]

canonical' n tiling = minimum $ map (\t -> t tiling) transformations where
  transformations = map (transform' n) [I, P, R, N, H, V, D, A]

allTilings' n = map (Map.fromList . zip keys) allPatterns where
  allPatterns = replicateM (n^2) [TileZ, TileS, TileH, TileN]
  keys = [(x, y) | x <- [1..n], y <- [1..n]]

canonical'' n tiling = minimum $ map (\t -> t tiling) transformations where
  transformations = map (transform'' n) [I, P, R, N, H, V, D, A]

allTilings'' n = map (Map.fromList . zip keys) allPatterns where
  allPatterns = replicateM (n^2) [TileU, TileD, TileL, TileR]
  keys = [(x, y) | x <- [1..n], y <- [1..n]]

