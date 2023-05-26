import Data.List
import Data.Set (Set)
import qualified Data.Set as Set
import Helpers.SetHelpers (flatMap)
import Helpers.Subsets (choose)

type Face = (Int, Int)
type Vertex = (Int, Int)
type Polyhex = Set Face
type Polytrihex = (Polyhex, Set Vertex)

polytrihexes :: Int -> Set Polytrihex
polytrihexes 0 = Set.singleton (Set.empty, Set.empty)
polytrihexes 1 = Set.fromList [(Set.singleton (0,0), Set.empty), (Set.empty, Set.singleton (1,0))]

directions = Set.fromList $ [(x-z,y-z) | [x,y,z] <- Data.List.permutations [-1,0,1]]

faceNeighbors :: Face -> Set Face
faceNeighbors (x1,y1) = Set.map (\(x2,y2) -> (x1+x2,y1+y2)) directions

neighboringFaces :: Polytrihex -> Set Face
neighboringFaces (polyhex, _) = Set.difference (flatMap faceNeighbors polyhex) polyhex

vertices :: Face -> Set Vertex
vertices (x,y) = Set.fromList [(x+1,y),(x-1,y),(x,y+1),(x,y-1),(x-1,y-1),(x+1,y+1)]

faces :: Vertex -> Set Face
faces (x, y)
  | even ((x+y) `mod` 3) = Set.fromList [(x+1, y), (x,y+1), (x-1,y-1)]
  | otherwise            = Set.fromList [(x-1, y), (x,y-1), (x+1,y+1)]

vertexCandidates :: Polytrihex -> Set Vertex
vertexCandidates (p, vs) = Set.difference (flatMap vertices p) vs

faceCandidates :: Polytrihex -> Set Face
faceCandidates (p, vs) = Set.difference (flatMap faces vs) p

fixedChildren :: Polytrihex -> Set Polytrihex
fixedChildren polytrihex = Set.union faceAdded vertexAdded  where
  faceAdded = Set.map (insertFace polytrihex) availableFaces where
    availableFaces = faceCandidates polytrihex
    insertFace (p, vs) f = (Set.insert f p, vs)
  vertexAdded = Set.map (insertVertex polytrihex) availableVertices where
    availableVertices = vertexCandidates polytrihex
    insertVertex (p,vs) v = (p, Set.insert v vs)

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

rotationsAboutOrigin :: Polytrihex -> Set Polytrihex
rotationsAboutOrigin (polyhex, vs) = Set.fromList $ map applyIsometry dihedralActions where
  applyIsometry f = (Set.map f polyhex, Set.map f vs)

allCenters :: Polytrihex -> Set Polytrihex
allCenters (polyhex,vs) = Set.map shift polyhex where
  shift cell = (Set.map (shiftBy cell) polyhex, Set.map (shiftBy cell) vs) where
    shiftBy (x1,y1) (x2,y2) = (x2-x1, y2-y1)

canonical :: Polytrihex -> Polytrihex
canonical polytrihex = Set.findMax $ flatMap rotationsAboutOrigin $ allCenters polytrihex

freeChildren :: Polytrihex -> Set Polytrihex
freeChildren = Set.map canonical . fixedChildren

a343398_list :: [Int]
a343398_list = 1 : map Set.size a343398_structures where
  a343398_structures = iterate (flatMap freeChildren) $ polytrihexes 1
