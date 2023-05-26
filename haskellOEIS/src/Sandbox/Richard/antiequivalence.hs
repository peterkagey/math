import Helpers.Subsets (allSubsets, eachPair)
import Data.List

-- See 2021-02-13T19:58:00 email from Richard.
-- Number of irreflexive, antisymmetric, antitransitive
-- a n = length $ filter (not . isAntitransitive) $ allAntisymmetricAndIrreflexive n
-- map a [0..]
-- [1,1,3,21,317,9735,
-- Bounded above by 3^Binomial(n,2).

allFlips :: [(Int, Int)] -> [[(Int, Int)]]
allFlips []  = [[]]
allFlips ((a,b):xs) = map ((a,b):) (allFlips xs) ++ map ((b,a):) (allFlips xs) ++ allFlips xs

allFlips' :: [(Int, Int)] -> [[(Int, Int)]]
allFlips' []  = [[]]
allFlips' ((a,b):xs) = map ([(a,b),(b,a)]++) (allFlips' xs) ++ map ((a,b):) (allFlips' xs) ++ map ((b,a):) (allFlips' xs) ++ allFlips' xs

allFlips'' :: [(Int, Int)] -> [[(Int, Int)]]
allFlips'' []  = [[]]
allFlips'' ((a,b):xs) = map ([(a,b),(b,a)]++) (allFlips'' xs) ++ map ((a,b):) (allFlips'' xs) ++ map ((b,a):) (allFlips'' xs) ++ allFlips'' xs

-- irreflexive, antisymmetric relations
allAntisymmetricAndIrreflexive n = allFlips $ eachPair [1..n]

allRelations n = allSubsets [(x,y) | x <- [1..n], y <- [1..n]]

allReflexiveRelations n = map (reflexive ++) $ allSubsets [(x,y) | x <- [1..n], y <- [1..n], x /= y] where
  reflexive = map (\x -> (x,x)) [1..n]

isAntitransitive :: [(Int, Int)] -> Bool
isAntitransitive xs  = all (edgeAntitransitive xs) xs

edgeAntitransitive :: [(Int, Int)] -> (Int, Int) -> Bool
edgeAntitransitive edges (x, y)  = null $ connectedEdges `intersect` edges where
  connectedEdges = map (\(_,y') -> (x,y')) $ filter (\(x',y') -> x' == y) edges

isTransitive :: [(Int, Int)] -> Bool
isTransitive xs  = all (edgeTransitive xs) xs

edgeTransitive :: [(Int, Int)] -> (Int, Int) -> Bool
edgeTransitive edges (x, y)  = all (`elem` edges) connectedEdges where
  connectedEdges = map (\(_,y') -> (x,y')) $ filter (\(x',y') -> x' == y) edges

isSymmetric :: [(Int, Int)] -> Bool
isSymmetric xs = all (\(a,b) -> (b,a) `elem` xs) xs

isAntisymmetric :: [(Int, Int)] -> Bool
isAntisymmetric xs = not $ any (\(a,b) -> (b,a) `elem` xs) xs

isIrreflexive :: [(Int, Int)] -> Bool
isIrreflexive = all (uncurry (/=))
