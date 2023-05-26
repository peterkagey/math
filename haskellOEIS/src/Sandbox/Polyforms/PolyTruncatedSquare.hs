import Data.List
import Data.Set (Set)
import qualified Data.Set as Set
import Helpers.SetHelpers (flatMap)
import Helpers.Subsets (choose)

type Face = (Int, Int)
type Vertex = (Int, Int)
type Polyhex = Set Face
type PolyTruncatedSquare = (Polyhex, Set Vertex)

polyTruncatedSquares :: Int -> Set PolyTruncatedSquare
polyTruncatedSquares 0 = Set.fromList [(Set.empty, Set.empty)]
polyTruncatedSquares 1 = Set.fromList [(Set.singleton (0,0), Set.empty), (Set.empty, Set.singleton (1,0))]

neighboringFaces :: PolyTruncatedSquare -> Set Face
neighboringFaces (polyomino, vs) = Set.difference (Set.union vertexAdjacentFaces faceAdjacentFaces) polyomino where
  vertexAdjacentFaces = flatMap facesFromVertex vs
  faceAdjacentFaces   = flatMap facesFromFace polyomino

verticesFromFace :: Face -> Set Vertex
verticesFromFace (x,y) = Set.fromList [(x+1,y),(x-1,y),(x,y+1),(x,y-1)]

facesFromVertex :: Vertex -> Set Face
facesFromVertex (x,y) = Set.fromList [(x+1,y),(x-1,y),(x,y+1),(x,y-1)]

facesFromFace :: Face -> Set Face
facesFromFace (x,y) = Set.fromList [(x+1,y+1),(x+1,y-1),(x-1,y+1),(x-1,y-1)]

neighboringVertices :: PolyTruncatedSquare -> Set Vertex
neighboringVertices (p, vs) = Set.difference (flatMap verticesFromFace p) vs

fixedChildren :: PolyTruncatedSquare -> Set PolyTruncatedSquare
fixedChildren polyTruncatedSquare = Set.union faceAdded vertexAdded  where
  faceAdded = Set.map (insertFace polyTruncatedSquare) availableFaces  where
    availableFaces = neighboringFaces polyTruncatedSquare
    insertFace (p, vs) f = (Set.insert f p, vs)
  vertexAdded = Set.map (insertVertex polyTruncatedSquare) availableVertices where
    availableVertices = neighboringVertices polyTruncatedSquare
    insertVertex (p,vs) v = (p, Set.insert v vs)

dihedralActions :: [(Int, Int) -> (Int, Int)]
dihedralActions = [p1, p2, p3, p4, p5, p6, p7, p8] where
  p1 (a, b) = ( a,  b)
  p2 (a, b) = ( a, -b)
  p3 (a, b) = (-a,  b)
  p4 (a, b) = (-a, -b)
  p5 (a, b) = ( b,  a)
  p6 (a, b) = ( b, -a)
  p7 (a, b) = (-b,  a)
  p8 (a, b) = (-b, -a)

rotationsAboutOrigin :: PolyTruncatedSquare -> Set PolyTruncatedSquare
rotationsAboutOrigin (polySquare, vs) = Set.fromList $ map applyIsometry dihedralActions where
  applyIsometry f = (Set.map f polySquare, Set.map f vs)

allCenters :: PolyTruncatedSquare -> Set PolyTruncatedSquare
allCenters (polySquare,vs) = Set.map shift polySquare where
  shift cell = (Set.map (shiftBy cell) polySquare, Set.map (shiftBy cell) vs) where
    shiftBy (x1,y1) (x2,y2) = (x2-x1, y2-y1)

canonical :: PolyTruncatedSquare -> PolyTruncatedSquare
canonical polyTruncatedSquare = Set.findMax $ flatMap rotationsAboutOrigin $ allCenters polyTruncatedSquare

freeChildren :: PolyTruncatedSquare -> Set PolyTruncatedSquare
freeChildren = Set.map canonical . fixedChildren

a343577_list :: [Int]
a343577_list = 1 : map Set.size a343577_structures where
  a343577_structures = iterate (flatMap freeChildren) $ polyTruncatedSquares 1
