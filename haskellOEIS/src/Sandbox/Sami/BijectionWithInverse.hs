import Data.Set (Set)
import qualified Data.Set as Set
import Data.List (permutations)

type CycleStructure = [[Int]]

phi k i p = phi' k i $ adjust i p

-- This is canonical order, but reading the cycles in reverse order.
-- e.g. (21)(5)(634) => [[6,3,4],[5],[2,1]]
fromWord p = recurse (length p) [] (Set.fromList [1..length p]) where
  recurse x currentCycle unseen
    | null unseen           = [reverse currentCycle]
    | x `Set.member` unseen = recurse (p !! (x-1)) (x:currentCycle) (Set.delete x unseen)
    | otherwise             = reverse currentCycle : recurse (maximum unseen) [] unseen

inPosition2 :: a -> [a] -> [a]
inPosition2 a [] = error "There's no second place for an Set.empty list!"
inPosition2 a (a1:as) = a1:a:as

left :: Int -> CycleStructure -> CycleStructure
left k [c1]            =  [init c1, [last c1]]
left k (c1:c2:cs)
  | last c1 > head c2   = init c1 : [last c1] : c2 : cs
  | length c2 == k      = init c1 : left  k (inPosition2 (last c1) c2 : cs)
  | length c2 == k - 1  = init c1 : right k (inPosition2 (last c1) c2 : cs)
  | otherwise           = init c1 :         (inPosition2 (last c1) c2 : cs)

right :: Int -> CycleStructure -> CycleStructure
right k [cycle] = [cycle] -- This is the state that fails to preserve k-cycles.
right k (c1:[c21]:cs) = (c1 ++ [c21]):cs
right k (c1:c2@(a21:a22:a2s):cs)
  | length c2 == k     = (c1 ++ [a22]) : right k ((a21:a2s) : cs)
  | length c2 == k + 1 = (c1 ++ [a22]) : left  k ((a21:a2s) : cs)
  | otherwise          = (c1 ++ [a22]) :          (a21:a2s) : cs

phi' :: Int -> Int -> CycleStructure -> CycleStructure
phi' k i [] = [[i]]
phi' k i pi@(c1@(a11:_):cs)
  | i > a11            = [i] : pi
  | length c1 == k     = left k  $ inPosition2 i c1 : cs
  | length c1 == k - 1 = right k $ inPosition2 i c1 : cs
  | otherwise          = inPosition2 i c1 : cs

psi' :: Int -> CycleStructure -> (Int, CycleStructure)
psi' k ([a11]:cs) = (a11, cs)
psi' k (c1@(a11:a12:as):cs)
  | length c1 == k     = (a12, right k $ (a11:as):cs)
  | length c1 == k + 1 = (a12, left k  $ (a11:as):cs)
  | otherwise          = (a12, (a11:as):cs)

adjust :: Int -> CycleStructure -> CycleStructure
adjust i = map (map incrementTheBigBoys) where
  incrementTheBigBoys x = if x >= i then x + 1 else x
