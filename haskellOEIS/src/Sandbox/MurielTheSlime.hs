import Data.Ratio (Ratio, (%))
-- From Jacob in the Math Oasis Discord Chat:
--
-- Muriel the slime mold sits at position 0 on the number line and weighs 1 unit
-- of slime. She locomotes by spreading slime: at any time, she may average the
-- amount of slime at positions n and n+1 on the number line, where n is an
-- integer.

-- Muriel has a very important date at +∞, so she is trying to move her center
-- of mass to the right as fast as possible. The greedy algorithm maximizing
-- change in center of mass at every time step has the following steps:

-- 0, 1, 0, 2, 1, 0, 2, 3, 1, 2, 4, 3, 1, 0, 2, 1, 4, 3, 2, 5, ...

-- murielState =
-- [1]             -> COM = 0
-- [1/2, 1/2]      -> COM = 1/2
-- [1/2, 1/4, 1/4] -> COM = 1/4 + 2*(1/4)
-- [3/8, 3/8, 1/4] -> COM = 3/8 + 2*(1/4)

centerOfMass :: Num t => [t] -> t
centerOfMass as = recurse 0 as 0 where
  recurse _ [] com = com
  recurse i (a:as) com = recurse (i+1) as (com + a * i)

locomote :: Int -> [Ratio Integer] -> [Ratio Integer]
locomote p as = prefix ++ suffix' where
  (prefix, suffix) = splitAt p as
  suffix' = case suffix of
    [a]        -> [a / 2, a / 2]
    (m1:m2:ms) -> [(m1+m2)/2, (m1+m2)/2] ++ ms

biggestStep as = recurse 0 (0,0) where
  lastStep = length as
  recurse i (pos, com)
    | i >= lastStep = pos
    | com' <= com   = recurse (i+1) (pos, com)
    | otherwise     = recurse (i+1) (i, com') where
      com' = centerOfMass (locomote i as)

goMuriel = recurse [1%1] where
  recurse as = p : recurse (locomote p as) where
    p = biggestStep as

goMuriel' = recurse [1%1] where
  recurse as = as : recurse (locomote p as) where
    p = biggestStep as

log_2 n = recurse 0 n where
  recurse i 1 = i
  recurse i k = recurse (i+1) (k `div` 2)
