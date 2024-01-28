module Sandbox.GridTiles.RectangularGridPrintingBeta (printCylinders, printTori, printGrids) where
import Sandbox.GridTiles.RectangularGridTiles (Tile(..))
import qualified Data.Map.Strict as Map
import Data.List (intercalate)
import Text.Printf

tileDeclarations = [
  "\\newcommand{\\tileId}{(0,1)--(1,1)--(1,0)--cycle}",
  "\\newcommand{\\tileF}{(0,0) -- (1/2, {sqrt(3/4)}) -- (1,0) -- cycle}",
  "\\newcommand{\\tileRR}{(0,0)--(0,0.25)--(0.75,1)--(1,1)--(1,0.75)--(0.25,0)--cycle (0.75,0)--(1,0.25)--(1,0)--cycle (0,1)--(0.25,1)--(0,0.75)--cycle}"
  ]

printTile :: Tile -> (Int, Int) -> String
printTile (TileColor 1) (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, black] (0,0) rectangle (1,1);" x y -- black
printTile (TileColor 2) (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, white] (0,0) rectangle (1,1);" x y -- white
-- □ ■ ■ □
-- ■ ■ ■ ■
-- ■ ■ ■ ■
-- □ ■ ■ □

printTile TileAdiag     (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={ 0:(1/2,1/2)}] \\tileRR;" x y -- /
printTile TileDiag      (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={90:(1/2,1/2)}] \\tileRR;" x y -- \
-- ■ ■ □ □
-- ■ ■ ■ □
-- □ ■ ■ ■
-- □ □ ■ ■

printTile TileU         (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={  0:(1/2,1/2)}] \\tileF;" x y -- ⇈
printTile TileD         (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={180:(1/2,1/2)}] \\tileF;" x y -- ⇊
printTile TileL         (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={ 90:(1/2,1/2)}] \\tileF;" x y -- ⇇
printTile TileR         (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={270:(1/2,1/2)}] \\tileF;" x y -- ⇉
-- ■ ■ ■ ■
-- ■ ■ ■ ■
-- □ □ □ □
-- □ □ □ □

printTile TileNE        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={  0:(1/2,1/2)}] \\tileId;" x y
printTile TileNW        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={ 90:(1/2,1/2)}] \\tileId;" x y
printTile TileSE        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={270:(1/2,1/2)}] \\tileId;" x y
printTile TileSW        (x, y) = printf "\\fill[shift={(%d+\\x,%d+\\y)}, rotate around={180:(1/2,1/2)}] \\tileId;" x y
-- ■ ■ ■ ■
-- ■ ■ ■ □
-- ■ ■ □ □
-- ■ □ □ □

printGrid tiling = intercalate "\n" $ header ++ body ++ footer where
  tileList = Map.toList tiling
  (n, m) = maximum $ map fst tileList
  header = ["\\begin{tikzpicture}", "\\pgfmathtruncatemacro{\\x}{0}", "\\pgfmathtruncatemacro{\\y}{0}"]
  body = ["  " ++ printTile t (x, y) | ((x,y), t) <- tileList]
  footer = [printf "  \\draw[gray] (0,0) grid (%d,%d);" (n+1) (m+1), "\\end{tikzpicture}"]

printCylinder :: Int -> Map.Map (Int, Int) Tile -> [Char]
printCylinder k tiling = intercalate "\n" $ header ++ body ++ footer where
  tileList = Map.toList tiling
  (n, m) = maximum $ map fst tileList
  header = [printf "\\pgfmathtruncatemacro{\\k}{%d}" k,
    "\\begin{tikzpicture}",
    "\\pgfmathtruncatemacro{\\y}{0}",
    "\\foreach \\x in {0,\\k,2*\\k} {"
    ]
  body = ["  " ++ printTile t (x, y) | ((x,y), t) <- tileList]
  footer = [printf "  \\draw[gray] (0,0) grid (%d,%d);" (3*k) (m+1), "}\n\\end{tikzpicture}"]

printTorus :: Int -> Int -> Map.Map (Int, Int) Tile -> [Char]
printTorus k1 k2 tiling = intercalate "\n" $ header ++ body ++ footer where
  tileList = Map.toList tiling
  (n, m) = maximum $ map fst tileList
  header = [printf "\\pgfmathtruncatemacro{\\n}{%d}" k1,
    printf "\\pgfmathtruncatemacro{\\m}{%d}" k2,
    "\\begin{tikzpicture}",
    "\\foreach \\x in {0,\\n,2*\\n} { \\foreach \\y in {0,\\m,2*\\m} {"
    ]
  body = ["  " ++ printTile t (x, y) | ((x,y), t) <- tileList]
  footer = [printf "  \\draw[gray] (0,0) grid (%d,%d);" (3*k1) (3*k2), "}}\n\\end{tikzpicture}"]

tikzWrap = (++[footer]) . (header:) where
  header = "\\documentclass[tikz]{standalone}\n\\usepackage{tikz}\n" ++ declareTiles ++"\n\\begin{document}"
  declareTiles = Data.List.intercalate "\n" tileDeclarations
  footer = "\\end{document}"

printTori :: Int -> Int -> [Map.Map (Int, Int) Tile] -> IO ()
printTori n m = putStrLn . Data.List.intercalate "\n" . tikzWrap . map (printTorus n m)

printGrids :: [Map.Map (Int, Int) Tile] -> IO ()
printGrids = putStrLn . Data.List.intercalate "\n" . tikzWrap . map printGrid

printCylinders :: Int -> [Map.Map (Int, Int) Tile] -> IO ()
printCylinders n = putStrLn . Data.List.intercalate "\n" . tikzWrap . map (printCylinder n)
