import Helpers.Table (tableByAntidiagonals)

-- Table read by antidiagonals downward.
-- The n-th row gives the linear recurrence with initial values
-- T(n,0) = 1, T(n,1) = 2, ..., T(floor(log_2(n))) = 2^floor(log_2(n))
-- and satisfying linear recurrence
-- T(n, k) = Sum_{i=0}^{floor(log_2(n))} A030190(n, i)*T(n, k-1-i) afterward.
-- n >= 1, k >= 0.

-- Comment:
-- This is the number of length k binary sequences with the property that every
-- length-M substring is lexicographically earlier than the binary representation
-- of n.

bitLength 0 = 0
bitLength n = 1 + bitLength (n `div` 2)

binary = reverse . binary'

binary' 0 = []
binary' n = n `mod` 2 : binary' (n `div` 2)

initialTerms n = map (2^) $ [0..bitLength n - 1]
-- initialTerms n = map (\k -> n `div` (2^k) + 1) $ reverse $ [1..bitLength n]
-- initialTerms n = replicate (bitLength n - 1) 0 ++ [1]

a999999_row n = knownTerms ++ recurse (reverse knownTerms) where
  knownTerms = initialTerms n
  base2 = binary n
  recurse l = nextTerm : recurse (nextTerm : l) where
    nextTerm = sum $ map (\i -> (base2 !! i) * (l !! i)) [0..bitLength n-1]

a999999_rows = map a999999_row [1..]

a999999_list = map (findEntry . tableByAntidiagonals) [0..] where
  findEntry (k, n) = a999999_rows !! n !! k

-- [x,x,x,x,x,x,x,1,1,1]
-- [x,x,x,x,x,x,2,2,2,2]
-- [x,x,x,x,x,13,21,34,55,89]
-- [x,x,x,x,4,4,4,4,4,4]
-- [x,x,x,5,7,11,16,23,34,50]
-- [x,x,4,6,10,16,26,42,68,110]

-- 1,
-- 1,1,
-- 1,2,1
-- 1,2,2,1
-- 1,2,3,2,1
-- 1,2,5,4,2,1
-- 1,2,4,4,8,2,1
