-- two :: [[(Int, Int)]]
two n = recurse [] [[1..2*n]] where
  recurse :: [(Int, Int)] -> [[Int]] -> [[(Int, Int)]]
  recurse pairs []                 = [pairs]
  recurse pairs ([]:y)             = recurse pairs y
  recurse pairs ((a:as):groupings) = concatMap (\i -> recurse ((a,i):pairs) (updated i)) allPairings where
    allPairings = filter (\b -> odd (a + b)) as
    updated x = case span (/= x) as of ([],_:cs) -> cs : groupings
                                       (as,_:cs) -> as : cs : groupings

-- count up to dihedral action
