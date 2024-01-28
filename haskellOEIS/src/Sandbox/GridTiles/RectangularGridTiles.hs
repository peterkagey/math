module Sandbox.GridTiles.RectangularGridTiles (Tile(..), V(..), transformTile) where

data Tile =
  TileColor Int |                   -- X       (Horizontal/vertical flip)
  TileDiag | TileAdiag |            -- ╲ ╱     (180° flip)
  TileU | TileD |                   -- ⇈ ⇊     (Horizontal flip)
  TileL | TileR |                   -- ⇇ ⇉     (Vertical flip)
  TileNE | TileNW | TileSE | TileSW -- ⬈ ⬉ ⬊ ⬋ (Asymmetric)
  deriving (Eq, Show, Ord)

-- I = Identity
-- R = 180° rotation
-- H = Horizontal flip
-- V = Vertical flip
data V = I | R | H | V deriving (Eq)

transformTile :: V -> Tile -> Tile
transformTile H (TileColor n) = TileColor n
transformTile V (TileColor n) = TileColor n
--
-- ╲ ╱     (180° flip)
transformTile H TileDiag = TileAdiag
transformTile H TileAdiag = TileDiag
transformTile V TileDiag = TileAdiag
transformTile V TileAdiag = TileDiag
--
-- ⇈ ⇊     (Horizontal flip)
transformTile H TileU = TileU
transformTile H TileD = TileD
transformTile V TileU = TileD
transformTile V TileD = TileU
--
-- ⇇ ⇉     (Vertical flip)
transformTile H TileL = TileR
transformTile H TileR = TileL
transformTile V TileL = TileL
transformTile V TileR = TileR
--
-- ⬈ ⬉ ⬊ ⬋ (Asymmetric)
transformTile H TileNE = TileNW
transformTile H TileNW = TileNE
transformTile H TileSW = TileSE
transformTile H TileSE = TileSW
transformTile V TileNE = TileSE
transformTile V TileNW = TileSW
transformTile V TileSE = TileNE
transformTile V TileSW = TileNW
--
transformTile I t     = t
transformTile R t     = transformTile H $ transformTile V t
