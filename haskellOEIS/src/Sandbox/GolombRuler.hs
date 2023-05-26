import Data.Set (Set)
import qualified Data.Set as Set
import Data.Maybe (Maybe, Maybe(..))
import Helpers.Subsets (choose)
-- We want to find the lexicographically earliest infinite sequence S such that
-- for all n, the first n terms of the sequence S^n has the property that
-- S^n + S^n + S^n has as many terms as possible, binom(n+2,3).

a347570_row n = 0 : (recurse 1 $ replicate n (Set.singleton 0)) where
  recurse i partialSums = go (insert i partialSums) where
    go Nothing             = recurse (i + 1) partialSums
    go (Just partialSums') = i : recurse (i + 1) partialSums'

insert :: Int -> [Set Int] -> Maybe [Set Int]
insert x chain = recurse (Set.singleton 0) (Just chain) where
  recurse :: Set Int -> Maybe [Set Int] -> Maybe [Set Int]
  recurse _ Nothing = Nothing
  recurse s1 (Just []) = Just []
  recurse s1 (Just (s2:s2s))
    | Set.map (+x) s1 `Set.disjoint` s2 = (s1':) <$> recurse s1' (Just s2s)
    | otherwise                         = Nothing where
      s1' = Set.map (+x) s1 `Set.union` s2

sequencesOfLength 0 _  = [[]]
sequencesOfLength k [] = []
sequencesOfLength k as'@(a:as) = seq1 ++ seq2 where
  seq1 = sequencesOfLength k as
  seq2 = map (a:) $ sequencesOfLength (k-1) as'

sequencesOfLength' k as = concatMap (\i -> sequencesOfLength i as) [0..k]

allDistinct :: Ord a => [a] -> Bool
allDistinct = recurse Set.empty where
  recurse _ [] = True
  recurse knownValues (a:as)
    | Set.member a knownValues = False
    | otherwise                = recurse (Set.insert a knownValues) as

-- moser2 n m = n + m + n*m
