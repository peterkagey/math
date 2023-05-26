import Data.Set (Set)
import qualified Data.Set as Set
import Data.List

a337226_list = 1 : recurse 1 Set.empty where
  recurse n ks = nextTerm : recurse (n + 1) (Set.union ks $ differences nextTerm) where
    knownSequence = take n a337226_list
    differences k = Set.fromList $ map (`subtract` n) $ Data.List.elemIndices k knownSequence
    nextTerm = head $ filter (Set.disjoint ks . differences) [1..]

a337226 n = a337226_list !! (n - 1)

a338091 n = (+) 1 $ head $ findIndices (uncurry (==)) $ zip a337226_list $ drop n a337226_list

a338092 = a337226 . a338091
