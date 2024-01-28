module Sandbox.GridTiles.SquareGridPrinting (printCylinders, printTori, printGrids) where
import Sandbox.GridTiles.SquareGridTiles (Tile(..))
import qualified Data.Map.Strict as Map
import Data.List (intercalate)
import Text.Printf

printTile :: Tile -> (Int, Int) -> String
printTile (TileColor 1) (x, y) = printf "\\fill[black] (%d,%d) rectangle (%d,%d);" x y (x+1) (y+1) -- black
printTile (TileColor 2) (x, y) = printf "\\fill[white] (%d,%d) rectangle (%d,%d);" x y (x+1) (y+1) -- white

printTile TileCW        (x, y) = printf "\\fill (%d,%d) arc(-90:90:1/3) (%d,%d) arc(0:180:1/3) (%d,%d) arc(90:270:1/3) (%d,%d) arc(180:360:1/3);"  x y (x+1) y (x+1) (y+1) x (y+1)
printTile TileCCW       (x, y) = printf "\\fill (%d,%d) arc(180:0:1/3) (%d,%d) arc(270:90:1/3) (%d,%d) arc(360:180:1/3) (%d,%d) arc(450:270:1/3);" x y (x+1) y (x+1) (y+1) x (y+1)

-- printTile TileHor       (x, y) = printf "\\fill (%d,%d) rectangle (%d,%d.333) (%d,%d.666) rectangle (%d,%d);" x y (x+1) y x y (x+1) (y+1) -- horizontal -
-- printTile TileVer       (x, y) = printf "\\fill (%d,%d) rectangle (%d.333,%d) (%d.666,%d) rectangle (%d,%d);" x y x (y+1) x y (x+1) (y+1) -- vertical   |
printTile TileHor       (x, y) = printf "\\fill (%d,%d)--(%d.333,%d)--(%d,%d.333)--(%d,%d)--(%d.666,%d)--(%d,%d.333) (%d,%d)--(%d.666,%d)--(%d,%d.666)--(%d,%d)--(%d.333,%d)--(%d,%d.666);" x y x y (x+1) y (x+1) y    x y     x y (x+1) (y+1) x (y+1) x     y x    (y+1) x (y+1) (x+1) y -- horizontal -
printTile TileVer       (x, y) = printf "\\fill (%d,%d)--(%d.333,%d)--(%d,%d.666)--(%d,%d)--(%d.333,%d)--(%d,%d.333) (%d,%d)--(%d.666,%d)--(%d,%d.333)--(%d,%d)--(%d.666,%d)--(%d,%d.666);"  x y x y x     y x    (y+1) x (y+1) x y (x+1) (y+1) x (y+1) (x+1) y (x+1) y    x y     (x+1) y -- vertical   |

printTile TileAdiag     (x, y) = printf "\\fill (%d,%d)--(%d.5,%d)--(%d,%d.5) (%d,%d)--(%d,%d.5)--(%d.5,%d);" x y x y x y (x+1) (y+1) (x+1) y x (y+1) -- /
printTile TileDiag      (x, y) = printf "\\fill (%d,%d)--(%d.5,%d)--(%d,%d.5) (%d,%d)--(%d,%d.5)--(%d.5,%d);" x (y+1) x (y+1) x y (x+1) y (x+1) y x y -- \

printTile TileZ         (x, y) = printf "\\fill (%d,%d)--(%d.5,%d)--(%d,%d)--(%d.5,%d);" x y x (y+1) (x+1) (y+1) x y -- ⇄
printTile TileS         (x, y) = printf "\\fill (%d,%d)--(%d.5,%d)--(%d,%d)--(%d.5,%d);" x (y+1) x (y+1) (x+1) y x y -- ⇆
printTile TileH         (x, y) = printf "\\fill (%d,%d)--(%d,%d.5)--(%d,%d)--(%d,%d.5);" x y x y (x+1) (y+1) (x+1) y -- ⇵
printTile TileN         (x, y) = printf "\\fill (%d,%d)--(%d,%d.5)--(%d,%d)--(%d,%d.5);" (x+1) y (x+1) y x (y+1) x y -- ⇅

printTile TileU         (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d.5,%d);" x y (x+1) y x (y+1) -- ⇈
printTile TileD         (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d.5,%d);" x (y+1) (x+1) (y+1) x y-- ⇊
printTile TileL         (x, y) = printf "\\fill (%d,%d.5)--(%d,%d)--(%d,%d);" x y (x+1) (y+1) (x+1) y -- ⇇
printTile TileR         (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d.5);" x y x (y+1) (x+1) y-- ⇉

printTile TileNE        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d);" (x+1) (y+1) x (y+1) (x+1) y
printTile TileNW        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d);" x (y+1) x y (x+1) (y+1)
printTile TileSE        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d);" (x+1) y (x+1) (y+1) x y
printTile TileSW        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d);" x y (x+1) y x (y+1)

printTile TileLU        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d.75)--(%d,%d.25);" (x+1) y x y x y (x+1) y -- ↼
printTile TileLD        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d.75)--(%d,%d.25);" x (y+1) (x+1) (y+1) (x+1) y x y -- ↽
printTile TileUR        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d.25,%d)--(%d.75,%d);" x (y+1) x y x y x (y+1) -- ↾
printTile TileUL        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d.25,%d)--(%d.75,%d);" (x+1) y (x+1) (y+1) x (y+1) x y -- ↿
printTile TileRU        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d.25)--(%d,%d.75);" (x+1) y x y x y (x+1) y -- ⇀
printTile TileRD        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d.25)--(%d,%d.75);" x (y+1) (x+1) (y+1) (x+1) y x y -- ⇁
printTile TileDR        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d.75,%d)--(%d.25,%d);" x (y+1) x y x y x (y+1) -- ⇂
printTile TileDL        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d.75,%d)--(%d.25,%d);" (x+1) y (x+1) (y+1) x (y+1) x y -- ⇃

printGrid tiling = intercalate "\n" $ header ++ body ++ footer where
  tileList = Map.toList tiling
  (n, m) = maximum $ map fst tileList
  header = ["\\begin{tikzpicture}"]
  body = ["  " ++ printTile t (x, y) | ((x,y), t) <- tileList]
  footer = [printf "  \\draw (0,0) grid (%d,%d);" (n+1) (m+1), "\\end{tikzpicture}"]

printCylinder k tiling = intercalate "\n" $ header ++ body ++ footer where
  tileList = Map.toList tiling
  (n, m) = maximum $ map fst tileList
  header = ["\\begin{tikzpicture}"]
  body = ["  " ++ printTile t (x + (n+1)*i, y) | ((x,y), t) <- tileList, i <- [0..k-1]]
  footer = [printf "  \\draw (0,0) grid (%d,%d);" (n*k +k) (m+1), "\\end{tikzpicture}"]

printTorus :: Int -> Map.Map (Int, Int) Tile -> [Char]
printTorus k tiling = intercalate "\n" $ header ++ body ++ footer where
  tileList = Map.toList tiling
  (n, m) = maximum $ map fst tileList
  header = ["\\begin{tikzpicture}"]
  body = ["  " ++ printTile t (x + (n+1)*i, y + (m+1)*j) | ((x,y), t) <- tileList, i <- [0..k-1], j <- [0..k-1]]
  footer = [printf "  \\draw (0,0) grid (%d,%d);" (n*k+k) (m*k+k), "\\end{tikzpicture}"]

tikzWrap = (++[footer]) . (header:) where
  header = "\\documentclass[tikz]{standalone}\n\\usepackage{tikz}\n\\begin{document}"
  footer = "\\end{document}"

printTori :: [Map.Map (Int, Int) Tile] -> IO ()
printTori = putStrLn . Data.List.intercalate "\n" . tikzWrap . map (printTorus 3)

printGrids :: [Map.Map (Int, Int) Tile] -> IO ()
printGrids = putStrLn . Data.List.intercalate "\n" . tikzWrap . map printGrid

printCylinders :: [Map.Map (Int, Int) Tile] -> IO ()
printCylinders = putStrLn . Data.List.intercalate "\n" . tikzWrap . map (printCylinder 3)


-- printTile TileLU (0,0)
-- printTile TileLD (0,0)
-- printTile TileUR (0,0)
-- printTile TileUL (0,0)
-- printTile TileRU (0,0)
-- printTile TileRD (0,0)
-- printTile TileDR (0,0)
-- printTile TileDL (0,0)
