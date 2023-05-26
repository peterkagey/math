import Data.Map (Map, (!))
import qualified Data.Map as Map
data Direction = GoRight | GoUp | GoLeft | GoDown deriving (Show, Eq)
nextDirection GoRight = GoUp
nextDirection GoUp = GoLeft
nextDirection GoLeft = GoDown
nextDirection GoDown = GoRight

-- (0,0)
-- R1: (1,0)
-- U1: (1,1)
-- L2: (0,1), (-1,1)
-- D2: (-1,0),(-1,-1)
-- R3: (0,-1),(1,-1),(2,-1)
-- U3: (2,0),(2,1),(2,2)
-- L4: (1,2),(0,2),(-1,2),(-1,3)

spiral = (0,0) : recurse (0,0) GoRight 1 where
  recurse (x,y) GoRight i = map (\j -> (x+j,y)) [1..i] ++ recurse (x+i,y) GoUp i
  recurse (x,y) GoUp    i = map (\j -> (x,y+j)) [1..i] ++ recurse (x,y+i) GoLeft (i+1)
  recurse (x,y) GoLeft  i = map (\j -> (x-j,y)) [1..i] ++ recurse (x-i,y) GoDown i
  recurse (x,y) GoDown  i = map (\j -> (x,y-j)) [1..i] ++ recurse (x,y-i) GoRight (i+1)

computeSequence = recurse spiral where
  recurse ((x,y):remaining)
