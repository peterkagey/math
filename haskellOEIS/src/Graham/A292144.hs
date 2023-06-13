module Graham.A292144 (a292144) where
import Math.NumberTheory.Roots (isSquare)

-- Naive, slow implementation.
a292144 n = head $ filter (isSquare . (n*)) $ reverse [0..n-1]
