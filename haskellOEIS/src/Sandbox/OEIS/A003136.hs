import Data.Set (Set)
import qualified Data.Set as Set
-- Reinhard Zumkeller, Oct 30 2011
a003136 :: Int -> Integer
a003136 n = a003136_list !! (n - 1)

a003136_list :: [Integer]
a003136_list = f 0 $ Set.singleton 0 where
  f x s
    | m < x ^ 2 = m : f x s'
    | otherwise = m : f x' (Set.union s' $ Set.fromList $ map (\y -> x'^2+(x'+y)*y) [0..x']) where
      x' = x + 1
      (m, s') = deleteFindMin s

a024610_list :: [Int]
a024610_list = recurse 1 0 a003136_list where
  recurse c k (a:as)
    | a == k^2  = c : recurse (c + 1) (k + 1) as
    | otherwise = recurse (c + 1) k as

a024610 :: Int -> Int
a024610 = (!!) a024610_list
