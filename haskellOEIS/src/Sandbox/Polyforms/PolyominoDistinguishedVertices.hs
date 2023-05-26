import Data.List
import Data.Set (Set)
import qualified Data.Set as Set
import Helpers.SetHelpers (flatMap)
import Helpers.Subsets (choose)

type Face = (Int, Int)
type Vertex = (Int, Int)
type Polyhex = Set Face
type PolyominoDistinguishedVertices = (Polyhex, Set Vertex)

polyTruncatedSquares :: Int -> Set PolyominoDistinguishedVertices
polyTruncatedSquares 0 = Set.fromList [(Set.empty, Set.empty)]
polyTruncatedSquares 1 = Set.fromList [(Set.singleton (0,0), Set.empty)]

faceNeighbors :: Face -> Set Face
faceNeighbors (x1,y1) = Set.fromList [(x1+1,y1+1),(x1+1,y1-1),(x1-1,y1+1),(x1-1,y1-1)]

neighboringFaces :: PolyominoDistinguishedVertices -> Set Face
neighboringFaces (polyomino, _) = Set.difference (flatMap faceNeighbors polyomino) polyomino

vertices :: Face -> Set Vertex
vertices (x,y) = Set.fromList [(x+1,y),(x-1,y),(x,y+1),(x,y-1)]

allVertices :: PolyominoDistinguishedVertices -> Set Vertex
allVertices (p, vs) = Set.difference (flatMap vertices p) vs

fixedChildren :: PolyominoDistinguishedVertices -> Set PolyominoDistinguishedVertices
fixedChildren polyTruncatedHex = Set.union faceAdded vertexAdded  where
  faceAdded = Set.map (insertFace polyTruncatedHex) $ neighboringFaces polyTruncatedHex where
    insertFace (p, vs) f = (Set.insert f p, vs)
  vertexAdded = Set.map (insertVertex polyTruncatedHex) availableVertices where
    availableVertices = allVertices polyTruncatedHex
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

rotationsAboutOrigin :: PolyominoDistinguishedVertices -> Set PolyominoDistinguishedVertices
rotationsAboutOrigin (polySquare, vs) = Set.fromList $ map applyIsometry dihedralActions where
  applyIsometry f = (Set.map f polySquare, Set.map f vs)

allCenters :: PolyominoDistinguishedVertices -> Set PolyominoDistinguishedVertices
allCenters (polySquare,vs) = Set.map shift polySquare where
  shift cell = (Set.map (shiftBy cell) polySquare, Set.map (shiftBy cell) vs) where
    shiftBy (x1,y1) (x2,y2) = (x2-x1, y2-y1)

canonical :: PolyominoDistinguishedVertices -> PolyominoDistinguishedVertices
canonical polyTruncatedHex = Set.findMax $ flatMap rotationsAboutOrigin $ allCenters polyTruncatedHex

freeChildren :: PolyominoDistinguishedVertices -> Set PolyominoDistinguishedVertices
freeChildren = Set.map canonical . fixedChildren

a343417_list :: [Int]
a343417_list = 1 : map Set.size a343417_structures where
  a343417_structures = iterate (flatMap freeChildren) $ polyTruncatedSquares 1
