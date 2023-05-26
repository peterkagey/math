import Sandbox.Partitions (Partition, partitionsWithMaxPart)
import Helpers.Subsets (eachPair)

data HeightSequence = EdgeRooted (Partition, Partition) | VertexRooted Partition deriving (Show)

-- A000677
-- heightSequenceOfEdgeRootedTree :: Int -> Int -> [(Partition, Partition)]
heightSequenceOfEdgeRootedTree n k = map EdgeRooted $ equal ++ unequal where
  equal = equalHeightEdgeRootedPartions n k
  unequal = concatMap f (unequalParititonPairSizes (n - 2*k)) where
    f (a,b) = [(k:p1, k:p2) | p1 <- partitionsWithMaxPart a k, p2 <- partitionsWithMaxPart b k]

unequalParititonPairSizes n = map (\i -> (n-i, i)) [0..(n-1)`div` 2]

equalHeightEdgeRootedPartions n k
  | odd n     = []
  | otherwise = map (\p -> (p, p)) ps ++ eachPair ps where
  ps = map (k:) $ partitionsWithMaxPart ((n - 2*k) `div` 2) k

heightSequenceOfVertexRootedTree n k = map VertexRooted $ map ([k,k]++) $ partitionsWithMaxPart (n-2*k) k

trees 1 = [VertexRooted []]
trees 2 = [EdgeRooted ([], [])]
trees n =  vRooted ++ eRooted ++ concatMap (trees') [1..n-1] where
  vRooted = concatMap (heightSequenceOfVertexRootedTree (n-1)) [1..(n-1) `div` 2]
  eRooted = concatMap (heightSequenceOfEdgeRootedTree (n-2)) [1..(n-2) `div` 2]

trees' n = vRooted ++ eRooted where
  vRooted = concatMap (heightSequenceOfVertexRootedTree (n-1)) [2..(n-1) `div` 2]
  eRooted = concatMap (heightSequenceOfEdgeRootedTree (n-2)) [2..(n-2) `div` 2]
