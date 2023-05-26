import Data.List
import Data.Set (Set)
import qualified Data.Set as Set
import Helpers.SetHelpers (flatMap)

type Face = (Int, Int)
type Vertex = (Int, Int)
type Polyhex = Set Face

polyhexes :: Int -> [Polyhex]
polyhexes 0 = [Set.empty]
polyhexes 1 = [Set.singleton (0,0)]
-- polyhexes n = map children $ polyhexes (n - 1)

directions = Set.fromList $ [(x-z,y-z) | [x,y,z] <- Data.List.permutations [-1,0,1]]

neighbors :: Face -> Set Face
neighbors (x1,y1) = Set.map (\(x2,y2) -> (x1+x2,y1+y2)) directions

childCells :: Polyhex -> Set Face
childCells polyhex = Set.difference (flatMap neighbors polyhex) polyhex

fixedChildren :: Polyhex -> Set Polyhex
fixedChildren polyhex = Set.map (`Set.insert` polyhex) (childCells polyhex)

freeChildren :: Polyhex -> Set Polyhex
freeChildren = Set.map canonical . fixedChildren

dihedralActions :: [(Int, Int) -> (Int, Int)]
dihedralActions = [p1, p2, p3, p4, p5, p6, p7, p8, p9, pA, pB, pC] where
  p1 (a, b) = (a, b)
  p2 (a, b) = (a-b, -b)
  p3 (a, b) = (b, a)
  p4 (a, b) = (b-a, -a)
  p5 (a, b) = (-b, a-b)
  p6 (a, b) = (-a, b-a)
  p7 (a, b) = (-a, -b)
  p8 (a, b) = (b-a, b)
  p9 (a, b) = (-b, -a)
  pA (a, b) = (a-b, a)
  pB (a, b) = (b, b-a)
  pC (a, b) = (a, a-b)

rotationsAboutOrigin :: Polyhex -> Set Polyhex
rotationsAboutOrigin polyhex = Set.fromList $ map (\f -> Set.map f polyhex) dihedralActions

allCenters :: Polyhex -> Set Polyhex
allCenters polyhex = Set.map shift polyhex where
  shift cell = Set.map (shiftBy cell) polyhex where
    shiftBy (x1,y1) (x2,y2) = (x2-x1, y2-y1)

canonical :: Polyhex -> Polyhex
canonical polyhex = Set.findMax $ flatMap rotationsAboutOrigin $ allCenters polyhex
