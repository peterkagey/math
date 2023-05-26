import Data.List (elemIndices, permutations)

type Permutation = [Int]

inv :: Permutation -> Permutation
inv p = map (head . (`elemIndices` p)) [0..2]

comp :: Permutation -> Permutation -> Permutation
comp [a,b,c] p = [p !! a, p !! b, p !! c]

klein :: [(Permutation, Permutation)]
klein = [(a, b) | a <- s3, b <- s3, a `comp` b `comp` inv a == inv b] where
  s3 = permutations [0..2]

torus :: [(Permutation, Permutation)]
torus = [(a, b) | a <- s3, b <- s3, a `comp` b == (b `comp` a)] where
  s3 = permutations [0..2]

xConjugates :: [(Permutation, Permutation)] -> [(Permutation, Permutation)]
xConjugates x = recurse x [] where
  recurse [] accum = accum
  recurse (t:ts) accum
    | any (t `isConjugateTo`) accum = recurse ts accum
    | otherwise                     = recurse ts (t:accum)

isConjugateTo :: (Permutation, Permutation) -> (Permutation, Permutation) -> Bool
isConjugateTo (p,p') (q, q') = any (\theta -> conjugateWith p q theta && conjugateWith p' q' theta) $ permutations [0..2]

conjugateWith :: Permutation -> Permutation -> Permutation -> Bool
conjugateWith p p' theta = theta `comp` p `comp` (inv theta) == p'
