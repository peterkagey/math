module Graham.A292144 (a292144) where
import Math.NumberTheory.Roots (isSquare)

-- Naive, slow implementation.
a292144 n = last $ filter (isSquare . (n *)) [0 .. n - 1]
