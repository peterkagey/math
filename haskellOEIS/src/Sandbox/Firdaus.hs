import Sandbox.Partitions (Partition, partitionsWithMaxPart)
import Data.List (findIndices)

--------------------------------------------

type Edge = (Int, Int)
type Status = (Partition, Partition, [Edge])

targetPartitions :: Int -> [Partition]
targetPartitions n = partitionsWithMaxPart (2*n) n

decrementAt :: Int -> Partition -> Partition
decrementAt 0 (a:as) = (a-1) : as
decrementAt n (a:as) = a : decrementAt (n-1) as

nextGen :: (Int, Partition, [Edge]) -> [(Int, Partition, [Edge])]
nextGen (n, partition, edges)
  | null as  = []
  | otherwise = map info $ filter (<=n) as where
    (a:as) = findIndices (>0) partition
    info i = (newIndex, decrementAt a (decrementAt i partition), (a,i):edges) where
      newIndex = if partition !! a == 1 then length partition else i

-- Given a partition, this enumerates the number of multigraphs with that degree sequence.
-- Cf. A209816, A328863.
findEdges :: Partition -> [[Edge]]
findEdges partition = recurse (sum partition `div` 2) [(length partition, partition, [])] where
  recurse 0 status = map (\(_,_,e) -> e) status
  recurse n status = recurse (n - 1) $ concatMap nextGen status

-- n\k | 2 | 3 |  4 |   5 |    6 | 7
-- ----+------------------+------+-----
--  1  | 1 | * |  3 |  *  |   15 | *     (A001147)
--  2  | 1 | 1 |  6 |  22 |  130 | 822   (A002137)
--  3  | 1 | * | 10 |   * |  760 | *     (A108243)
--  4  | 1 | 1 | 15 | 158 | 3355 | 93708
--                          A244878

table :: Int -> Int -> Int
table n k = length $ findEdges $ replicate k n

a999999 n = sum $ map (length . findEdges) $ targetPartitions n

-- Optimization: Use knowledge that (length . findEdges) [replicate k 1] == A001147 k
