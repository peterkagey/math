module Sandbox.GridTiles.SquareGridPrintingBeta (printCylinders, printTori, printGrids) where
import Sandbox.GridTiles.SquareGridTiles (Tile(..))
import qualified Data.Map.Strict as Map
import Data.List (intercalate)
import Text.Printf

-- I = Identity
-- P = +90º rotation
-- R = 180° rotation
-- N = -90º rotation
-- H = Horizontal flip
-- V = Vertical flip
-- D = Diagonal flip
-- A = Antidiagonal flip

tileDeclarations = [
  "\\newcommand{\\tileR}{(0,0) arc(-90:90:1/4) (1,0) arc(0:180:1/4) (1,1) arc(90:270:1/4) (0,1) arc(180:360:1/4)}",
  "\\newcommand{\\tileF}{(0,0) -- (1/2, {sqrt(3/4)}) -- (1,0) -- cycle}",
  "\\newcommand{\\tileId}{(1,0) -- (0, 0) -- (0,3/4) -- (1,1/4) -- cycle}",
  "\\newcommand{\\tileRF}{(0,1)--(1,1)--(1,0)--cycle}",
  "\\newcommand{\\tileFandRRF}{(0,1/4) rectangle (1,3/4)}",
  "\\newcommand{\\tileRFandRRRF}{(0,0)--(0,0.25)--(0.75,1)--(1,1)--(1,0.75)--(0.25,0)--cycle (0.75,0)--(1,0.25)--(1,0)--cycle (0,1)--(0.25,1)--(0,0.75)--cycle}",
  "\\newcommand{\\tileRR}{(0,0)--(0,1/2)--(2/3,2/3)--(1,1)--(1,1/2)--(1/3,1/3)--cycle}"
  ]

printTile :: Tile -> (Int, Int) -> String
printTile (TileColor 1) (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, black] (0,0) rectangle (1,1);" x y -- black
printTile (TileColor 2) (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, white] (0,0) rectangle (1,1);" x y -- white
-- □ ■ ■ □
-- ■ ■ ■ ■
-- ■ ■ ■ ■
-- □ ■ ■ □

printTile TileCW        (x, y) = printf "\\fill[shift={(%d+\\x+1,%d+\\y)}, xscale=-1] \\tileR;" x y
printTile TileCCW       (x, y) = printf "\\fill[shift={(%d+\\x+0,%d+\\y)}, xscale= 1] \\tileR;" x y
-- Alternatives
-- (0,0)--(1,1)--(1,1/2)--(0,1/2)--cycle (0,1)--(1,0)--(1/2,0)--(1/2,1)--cycle

printTile TileHor       (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={ 0:(1/2,1/2)}] \\tileFandRRF;" x y -- horizontal -
printTile TileVer       (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={90:(1/2,1/2)}] \\tileFandRRF;" x y -- vertical   |
-- □ ■ ■ □
-- □ ■ ■ □
-- □ ■ ■ □
-- □ ■ ■ □

printTile TileAdiag     (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={ 0:(1/2,1/2)}] \\tileRFandRRRF;" x y -- /
printTile TileDiag      (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={90:(1/2,1/2)}] \\tileRFandRRRF;" x y -- \
-- ■ ■ □ □
-- ■ ■ ■ □
-- □ ■ ■ ■
-- □ □ ■ ■

printTile TileZ         (x, y) = printf "\\fill[shift={(%d+\\x+0,%d+\\y)}, xscale =  1, rotate around={  0:(1/2,1/2)}] \\tileRR;" x y -- ⇄
printTile TileS         (x, y) = printf "\\fill[shift={(%d+\\x+1,%d+\\y)}, xscale = -1, rotate around={  0:(1/2,1/2)}] \\tileRR;" x y -- ⇆
printTile TileH         (x, y) = printf "\\fill[shift={(%d+\\x+1,%d+\\y)}, xscale = -1, rotate around={ 90:(1/2,1/2)}] \\tileRR;" x y -- ⇵
printTile TileN         (x, y) = printf "\\fill[shift={(%d+\\x+0,%d+\\y)}, xscale =  1, rotate around={ 90:(1/2,1/2)}] \\tileRR;" x y -- ⇅
-- ■ □ □ ■
-- ■ ■ □ ■
-- ■ □ ■ ■
-- ■ □ □ ■

printTile TileU         (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={  0:(1/2,1/2)}] \\tileF;" x y -- ⇈
printTile TileD         (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={180:(1/2,1/2)}] \\tileF;" x y -- ⇊
printTile TileL         (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={ 90:(1/2,1/2)}] \\tileF;" x y -- ⇇
printTile TileR         (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={270:(1/2,1/2)}] \\tileF;" x y -- ⇉
-- ■ ■ ■ ■
-- ■ ■ ■ ■
-- □ □ □ □
-- □ □ □ □


printTile TileNE        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={  0:(1/2,1/2)}] \\tileRF;" x y
printTile TileNW        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={ 90:(1/2,1/2)}] \\tileRF;" x y
printTile TileSE        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={270:(1/2,1/2)}] \\tileRF;" x y
printTile TileSW        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={180:(1/2,1/2)}] \\tileRF;" x y
-- ■ ■ ■ ■
-- ■ ■ ■ □
-- ■ ■ □ □
-- ■ □ □ □

printTile TileLU        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y+0)}, yscale =  1, rotate around={  0:(1/2,1/2)}] \\tileId;" x y -- ↼
printTile TileLD        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y+1)}, yscale = -1, rotate around={  0:(1/2,1/2)}] \\tileId;" x y -- ↽
printTile TileUR        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y+0)}, yscale =  1, rotate around={270:(1/2,1/2)}] \\tileId;" x y -- ↾
printTile TileUL        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y+1)}, yscale = -1, rotate around={270:(1/2,1/2)}] \\tileId;" x y -- ↿
printTile TileRU        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y+1)}, yscale = -1, rotate around={180:(1/2,1/2)}] \\tileId;" x y -- ⇀
printTile TileRD        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y+0)}, yscale =  1, rotate around={180:(1/2,1/2)}] \\tileId;" x y -- ⇁
printTile TileDR        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y+1)}, yscale = -1, rotate around={ 90:(1/2,1/2)}] \\tileId;" x y -- ⇂
printTile TileDL        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y+0)}, yscale =  1, rotate around={ 90:(1/2,1/2)}] \\tileId;" x y  -- ⇃
-- ■ ■ ■ ■
-- ■ ■ □ ■
-- ■ □ □ □
-- □ □ □ □

printGrid tiling = intercalate "\n" $ header ++ body ++ footer where
  tileList = Map.toList tiling
  (n, m) = maximum $ map fst tileList
  header = ["\\begin{tikzpicture}", "\\pgfmathtruncatemacro{\\x}{0}", "\\pgfmathtruncatemacro{\\y}{0}"]
  body = ["  " ++ printTile t (x, y) | ((x,y), t) <- tileList]
  footer = [printf "  \\draw[gray] (0,0) grid (%d,%d);" (n+1) (m+1), "\\end{tikzpicture}"]

printTorus :: Int -> Map.Map (Int, Int) Tile -> [Char]
printTorus k tiling = intercalate "\n" $ header ++ body ++ footer where
  tileList = Map.toList tiling
  (n, m) = maximum $ map fst tileList
  header = [printf "\\pgfmathtruncatemacro{\\k}{%d}" k,
    "\\begin{tikzpicture}",
    "\\foreach \\x in {0,\\k,2*\\k} { \\foreach \\y in {0,\\k,2*\\k} {"
    ]
  body = ["  " ++ printTile t (x, y) | ((x,y), t) <- tileList]
  footer = [printf "  \\draw[gray] (0,0) grid (%d,%d);" (3*k) (3*k), "}}\n\\end{tikzpicture}"]

tikzWrap = (++[footer]) . (header:) where
  header = "\\documentclass[tikz]{standalone}\n\\usepackage{tikz}\n" ++ declareTiles ++"\n\\begin{document}"
  declareTiles = Data.List.intercalate "\n" tileDeclarations
  footer = "\\end{document}"

printTori :: Int -> [Map.Map (Int, Int) Tile] -> IO ()
printTori n = putStrLn . Data.List.intercalate "\n" . tikzWrap . map (printTorus n)

printGrids :: [Map.Map (Int, Int) Tile] -> IO ()
printGrids = putStrLn . Data.List.intercalate "\n" . tikzWrap . map printGrid

-- printTile TileLU (0,0)
-- printTile TileLD (0,0)
-- printTile TileUR (0,0)
-- printTile TileUL (0,0)
-- printTile TileRU (0,0)
-- printTile TileRD (0,0)
-- printTile TileDR (0,0)
-- printTile TileDL (0,0)
