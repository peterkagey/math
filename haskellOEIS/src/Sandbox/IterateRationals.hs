import Data.Set (Set)
import qualified Data.Set as Set
import Data.Ratio ((%))
import Helpers.SetHelpers (flatMap)

-- https://mathoverflow.net/q/413087/104733#comment1058750_413087

fractions = recurse [0%1] where
  recurse as = as : recurse (concatMap f as)

f a
  | a == 0 % 1 = [1 % 1]
  | otherwise  = [a + 1, -1/a]

fractions' = recurse (Set.singleton (0%1)) (Set.singleton (0%1)) where
  recurse as seenTerms = as : recurse (Set.difference as' seenTerms) (Set.union as' seenTerms)where
    as' = flatMap f' as

f' a
  | a == 0 % 1 = Set.singleton (1 % 1)
  | otherwise  = Set.fromList [a + 1, -1/a]

-- How many steps to make A038568(n)/A038568(n+1)?
  -- 0, 1, 4, 2, 7, 5, 5, 3, 10, 8
-- How many steps to make -A038568(n)/A038568(n+1)?
  -- 0, 1, 4, 2, 7, 5, 5, 3, 10, 8
-- Largest denominator that can be formed in exactly n steps?
  -- 1,1,1,2,3,4,5,6,8,11,15,19,24,30,41,56,72,91,115,153
  -- map (maximum . Set.map Data.Ratio.denominator) $ take 20 $ fractions'

-- https://oeis.org/A226247
fractions'' = recurse [0%1] (Set.singleton (0%1)) where
  recurse as seenTerms = as : recurse as' seenTerms' where
    as' = filter (`Set.notMember` seenTerms ) $ concatMap f as
    seenTerms' = Set.union seenTerms (Set.fromList as')

-- https://oeis.org/A226130
fractions''' = recurse [1%1] (Set.singleton (1%1)) where
  recurse as seenTerms = as : recurse as' seenTerms' where
    as' = filter (`Set.notMember` seenTerms ) $ concatMap f as
    seenTerms' = Set.union seenTerms (Set.fromList as')
