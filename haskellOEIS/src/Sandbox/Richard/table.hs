-- 1
-- 2,  1
-- 6,  2,  1
-- 24,  9,  2, 1
-- 120, 44, 13, ?, 1

type Board = [(Int, Int)]

-- patternAvoidingPermutations board n = ???

-- Not smart, since it doesn't use the results from (k-1) to help compute k.
-- Also, not tail recursive.
nonAttackingRookCount 0 _     = 1
nonAttackingRookCount _ []    = 0
nonAttackingRookCount k ((x,y):rs) = nonAttackingRookCount (k - 1) rs' + nonAttackingRookCount k rs where
  rs' = filter (\(a, b) -> a /= x && b /= y) rs
