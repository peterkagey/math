import Data.MemoCombinators (memo2, integral)
import Helpers.Table (tableByAntidiagonals, triangleByRows, indicesByAntidiagonals, triangularize, antidiagonalize, formatTable)

t = memo2 integral integral t' where
  t' 1 r = [[r]]
  t' i r = map (r:) $ concatMap (\r' -> t (i-1) r') [0..r]

infiniteTable = map (\i -> map sum $ concatMap (\r -> t i r) [0..]) [1..]

a354388 n = case tableByAntidiagonals (n - 1) of (x, y) -> infiniteTable !! x !! y
