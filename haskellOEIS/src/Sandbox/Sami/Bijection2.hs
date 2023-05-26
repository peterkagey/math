module Sandbox.CycleStructure where
import Data.Set (Set)
import qualified Data.Set as Set
import Data.List (permutations, (\\))

type PermutationWord = [Int]
type Cycle = [Int]
type CycleStructure = [[Int]]

fromWord p = recurse 1 [] (Set.fromList [1..length p]) where
  recurse x currentCycle unseen
    | null unseen       = [reverse currentCycle]
    | x `Set.member` unseen = recurse (p !! (x-1)) (x:currentCycle) (Set.delete x unseen)
    | otherwise         = reverse currentCycle : recurse (minimum unseen) [] unseen

fromCycleStructure c = map findValue [1..n] where
  n = maximum $ concat c
  findValue = recurse c where
    recurse (c':cs') i
      | i `notElem` c' = recurse cs' i
      | otherwise      = case dropWhile (/= i) c' of [_]     -> head c'
                                                     (_:a:_) -> a

rescale :: Int -> CycleStructure -> CycleStructure
rescale k pi
  | k `notElem` concat pi = pi
  | otherwise = map rescale' pi where
    rescale'  = map (\i -> if i >=k then i + 1 else i)

phi :: Int -> Int -> CycleStructure -> CycleStructure
phi k i pi = phi' $ rescale i pi where
  phi' [] = [[i]]
  phi' pi'@(c1:cs)
    | i < head c1        = [i]:c1:cs
    | length c1 == k     = case c1 of (a1:a2:as) -> (a1:i:as) : phi k a2 cs
    | length c1 == k - 1 = p i $ psi k c1 cs
    | otherwise          = p i pi'

psi :: Int -> Cycle -> CycleStructure -> CycleStructure
psi k a's [] = [a's]
psi k (a'1:a's) pi@([a1]:cs) = (a'1:a1:a's) : cs
psi k (a'1:a's) (c1@(a1:a2:as):cs)
  | length c1 == k     = (a'1:a2:a's) : psi k (a1:as) cs
  | length c1 == k + 1 = (a'1:a2:a's) : init (a1:as) : phi k (last as) cs
  | otherwise           = (a'1:a2:a's) : (a1:as) : cs

p :: Int -> CycleStructure -> CycleStructure
p i ((a1:as):cs) = (a1:i:as):cs

-- How to invert this?
