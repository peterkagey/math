module Sandbox.GridTiles.RectangularGridPrinting (printCylinders, printTori, printGrids) where
import Sandbox.GridTiles.RectangularGridTiles (Tile(..))
import qualified Data.Map.Strict as Map
import Data.List (intercalate)
import Text.Printf

printTile :: Tile -> (Int, Int) -> String
printTile (TileColor 1) (x, y) = printf "\\fill[black!90!white] (%d,%d) rectangle (%d,%d);" x y (x+1) (y+1) -- black
printTile (TileColor 2) (x, y) = printf "\\fill[black!10!white] (%d,%d) rectangle (%d,%d);" x y (x+1) (y+1) -- white
-- printTile (TileColor 1) (x, y) = printf "\\fill (%d,%d)--(%d.333,%d)--(%d,%d.333)--(%d,%d)--(%d.666,%d)--(%d,%d.333) (%d,%d)--(%d.666,%d)--(%d,%d.666)--(%d,%d)--(%d.333,%d)--(%d,%d.666);" x y x y (x+1) y (x+1) y    x y     x y (x+1) (y+1) x (y+1) x     y x    (y+1) x (y+1) (x+1) y -- horizontal -
-- printTile (TileColor 2) (x, y) = printf "\\fill (%d,%d)--(%d.333,%d)--(%d,%d.666)--(%d,%d)--(%d.333,%d)--(%d,%d.333) (%d,%d)--(%d.666,%d)--(%d,%d.333)--(%d,%d)--(%d.666,%d)--(%d,%d.666);"  x y x y x     y x    (y+1) x (y+1) x y (x+1) (y+1) x (y+1) (x+1) y (x+1) y    x y     (x+1) y -- vertical   |

printTile TileAdiag     (x, y) = printf "\\fill (%d,%d)--(%d.5,%d)--(%d,%d.5) (%d,%d)--(%d,%d.5)--(%d.5,%d);" x y x y x y (x+1) (y+1) (x+1) y x (y+1) -- /
printTile TileDiag      (x, y) = printf "\\fill (%d,%d)--(%d.5,%d)--(%d,%d.5) (%d,%d)--(%d,%d.5)--(%d.5,%d);" x (y+1) x (y+1) x y (x+1) y (x+1) y x y -- \

printTile TileU         (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d.5,%d);" x y (x+1) y x (y+1) -- ⇈
printTile TileD         (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d.5,%d);" x (y+1) (x+1) (y+1) x y-- ⇊
printTile TileL         (x, y) = printf "\\fill (%d,%d.5)--(%d,%d)--(%d,%d);" x y (x+1) (y+1) (x+1) y -- ⇇
printTile TileR         (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d.5);" x y x (y+1) (x+1) y-- ⇉

printTile TileNE        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d);" (x+1) (y+1) x (y+1) (x+1) y
printTile TileNW        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d);" x (y+1) x y (x+1) (y+1)
printTile TileSE        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d);" (x+1) y (x+1) (y+1) x y
printTile TileSW        (x, y) = printf "\\fill (%d,%d)--(%d,%d)--(%d,%d);" x y (x+1) y x (y+1)

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
