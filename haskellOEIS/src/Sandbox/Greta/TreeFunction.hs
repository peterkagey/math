import Data.List (group, permutations)
data Tree = Branch [Tree] | Leaf deriving (Eq, Show)

type Forest    = [Tree]
type Harvestable = Forest
type OldGrowth   = Forest
type Lumberyard  = (Harvestable, OldGrowth)
type Partition = [Int]
type Composition = [Int]

fromParenthesis :: String -> Tree
-- fromParenthesis "" = Leaf
fromParenthesis "()" = Leaf
fromParenthesis parens = Branch $ map fromParenthesis $ partitionParenthesis $ inner parens

inner :: String -> String
inner "" = error "empty"
inner "a" = error "length 1"
inner s = init $ tail s

-- () is a single leaf
-- (()) is a 2-vertex tree
-- ((())) and (()()) are 3-vertex trees rooted at first and second vertex respectively.
partitionParenthesis :: String -> [String]
partitionParenthesis "" = []
partitionParenthesis parens = recurse 0 "" parens where
  recurse :: Int -> String -> String -> [String]
  recurse 1 s (')':remaining) = reverse (')':s) : partitionParenthesis remaining
  recurse n s ('(':remaining) = recurse (n+1) ('(':s) remaining
  recurse n s (')':remaining) = recurse (n-1) (')':s) remaining
  recurse n s "" = error $ show n
  -- recurse n ("(":remaining)) =

-- gretasFunction :: Forest -> Partition -> Integer
-- gretasFunction f (p:ps) = recurse ps (takeFromTree p f) where
  -- recurse [] forests

size :: Tree -> Int
size Leaf = 1
size (Branch trees) = 1 + sum (map size trees)

takeOne :: Tree -> Forest
takeOne Leaf = []
takeOne (Branch subTrees) = subTrees

takeFromTree :: Int -> Tree -> [Forest]
takeFromTree n t = recurse n [([t], [])] where
  recurse :: Int -> [Lumberyard] -> [Forest]
  recurse 0 f = map (uncurry (++)) f
  recurse n f = recurse (n - 1) (concatMap nextGen f)

takeFromForest :: Int -> Forest -> [Forest]
takeFromForest n forest = concatMap takeTree $ tailsAndInits forest where
  -- First forest can be harvested, second forest is old growth.
  takeTree :: Lumberyard -> [Forest]
  takeTree (t:ts, is)
    | size t >= n = map (++ ts ++ is) $ takeFromTree n t
    | otherwise     = []

takeFromForest' :: Int -> Forest -> [Lumberyard]
takeFromForest' n forest = concatMap (takeFromFirstTreeInLumberyard n) $ tailsAndInits forest

takeFromFirstTreeInLumberyard :: Int -> Lumberyard -> [Lumberyard]
takeFromFirstTreeInLumberyard n (t:ts, is)
  | size t >= n = map (\forest -> (forest ++ ts, is)) $ takeFromTree n t
  | otherwise   = []

takeFromLumberyard :: Int -> Lumberyard -> [Lumberyard]
takeFromLumberyard n (harvestable, oldGrowths) = map (\(hs, os) -> (hs, os ++ oldGrowths)) $ takeFromForest' n harvestable

nextGen :: Lumberyard -> [Lumberyard]
nextGen (harvestable, oldGrowth) = map (\(t:ts, is) -> (takeOne t ++ ts, is ++ oldGrowth)) $ tailsAndInits harvestable

tailsAndInits :: [a] -> [([a], [a])]
tailsAndInits [] = []
tailsAndInits as = recurse as [] where
  recurse :: [a] -> [a] -> [([a], [a])]
  recurse [] ts = [] -- [([], ts)]
  recurse is'@(i:is) ts = (is', ts) : recurse is (i:ts)

partitionOrders :: Partition -> [Composition]
partitionOrders = map concat . permutations . group

treeDissectionCount :: Tree -> Partition -> Int
treeDissectionCount t (p:ps) = recurse p ps [([t],[])] where
  recurse :: Int -> Partition -> [Lumberyard] -> Int
  recurse n [] lumberyards = length $ concatMap (takeFromLumberyard n) lumberyards
  recurse n (c:cs) lumberyards
    | n == c    = recurse c cs $ concatMap (takeFromLumberyard n) lumberyards
    | otherwise = recurse c cs $ map (\(h, o) -> (h ++ o, [])) $ concatMap (takeFromLumberyard n) lumberyards

treePartitionCount :: Tree -> Partition -> Int
treePartitionCount t p = sum $ map (treeDissectionCount t) $ partitionOrders p
