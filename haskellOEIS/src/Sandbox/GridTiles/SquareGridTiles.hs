module Sandbox.GridTiles.SquareGridTiles (Tile(..), D8(..), transformTile) where

-- I = Identity
-- P = +90º rotation
-- R = 180° rotation
-- N = -90º rotation
-- H = Horizontal flip
-- V = Vertical flip
-- D = Diagonal flip
-- A = Antidiagonal flip
data D8 = I | P | R | N | H | V | D | A deriving (Eq)

data Tile =
  TileColor Int |                     -- Full D8 symmetry
  TileCW | TileCCW |                  -- ⟳ ⟲     (90° symmetry)
  TileHor | TileVer |                 -- ╪ ╫     (Horizontal/vertical flip)
  TileDiag | TileAdiag |              -- ╲ ╱     (Antidiagonal/diagonal flip)
  TileZ | TileS | TileH | TileN |     -- ⇄ ⇆ ⇵ ⇅ (180° symmetry)
  TileU | TileD | TileL | TileR |     -- ⇈ ⇊ ⇇ ⇉ (Horizontal flip)
  TileNE | TileNW | TileSE | TileSW | -- ⬈ ⬉ ⬊ ⬋ (Transpose)
  TileLU | TileLD | TileUR | TileUL | TileRU | TileRD | TileDR | TileDL -- ↼ ↽ ↾ ↿ ⇀ ⇁ ⇂ ⇃ (asymmetric)
  deriving (Eq, Show, Ord)

transformTile :: D8 -> Tile -> Tile
transformTile P (TileColor n) = TileColor n
transformTile H (TileColor n) = TileColor n
--
-- ⟳ ⟲     (90° symmetry)
transformTile P TileCW = TileCW
transformTile P TileCCW = TileCCW
transformTile H TileCW = TileCCW
transformTile H TileCCW = TileCW
--
-- ╪ ╫     (Horizontal/vertical flip)
transformTile H TileHor = TileHor
transformTile H TileVer = TileVer
transformTile P TileHor = TileVer
transformTile P TileVer = TileHor
--
-- ╲ ╱     (Antidiagonal/diagonal flip)
transformTile H TileDiag = TileAdiag
transformTile H TileAdiag = TileDiag
transformTile P TileDiag = TileAdiag
transformTile P TileAdiag = TileDiag
--
-- ⇄ ⇆ ⇵ ⇅ (180° symmetry)
transformTile H TileZ = TileS
transformTile H TileS = TileZ
transformTile H TileH = TileN
transformTile H TileN = TileH
transformTile P TileZ = TileN
transformTile P TileS = TileH
transformTile P TileH = TileS
transformTile P TileN = TileZ
--
-- ⇈ ⇊ ⇇ ⇉ (Horizontal flip)
transformTile P TileU = TileL
transformTile P TileD = TileR
transformTile P TileL = TileD
transformTile P TileR = TileU
transformTile H TileU = TileU
transformTile H TileD = TileD
transformTile H TileL = TileR
transformTile H TileR = TileL
--
-- TileNE | TileNW | TileSE | TileSW | -- ⬈ ⬉ ⬊ ⬋ (Transpose)
transformTile P TileNE = TileNW
transformTile P TileNW = TileSW
transformTile P TileSW = TileSE
transformTile P TileSE = TileNE
transformTile H TileNE = TileNW
transformTile H TileNW = TileNE
transformTile H TileSW = TileSE
transformTile H TileSE = TileSW
--
-- TileLU | TileLD | TileUR | TileUL | TileRU | TileRD | TileDR | TileDL -- ↼ ↽ ↾ ↿ ⇀ ⇁ ⇂ ⇃ (asymmetric)
transformTile P TileLU = TileDL -- ↼ to ⇃
transformTile P TileDL = TileRD -- ⇃ to ⇁
transformTile P TileRD = TileUR -- ⇁ to ↾
transformTile P TileUR = TileLU -- ↾ to ↼
transformTile P TileLD = TileDR -- ↽ to ⇂
transformTile P TileDR = TileRU -- ⇂ to ⇀
transformTile P TileRU = TileUL -- ⇀ to ↿
transformTile P TileUL = TileLD -- ↿ to ↽
transformTile H TileLU = TileRU -- ↼ to ⇀
transformTile H TileLD = TileRD -- ↽ to ⇁
transformTile H TileUR = TileUL -- ↾ to ↿
transformTile H TileUL = TileUR -- ↿ to ↾
transformTile H TileRU = TileLU -- ⇀ to ↼
transformTile H TileRD = TileLD -- ⇁ to ↽
transformTile H TileDR = TileDL -- ⇂ to ⇃
transformTile H TileDL = TileDR -- ⇃ to ⇂
--
transformTile I t     = t
transformTile R t     = transformTile P $ transformTile P t
transformTile N t     = transformTile P $ transformTile R t
transformTile V t     = transformTile R $ transformTile H t
transformTile D t     = transformTile N $ transformTile H t
transformTile A t     = transformTile P $ transformTile H t
