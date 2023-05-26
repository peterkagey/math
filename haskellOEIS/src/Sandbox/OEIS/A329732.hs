import Math.NumberTheory.Powers.Cubes (isCube')
import Data.List (subsequences, delete)

a329732 n = last $ head $ filter (isCube' . product) $ map (n:) $ subsequences [n+1..]

g n k = filter (isCube' . product) $ map ([n,k]++) $ subsequences [n+1..k-1]

primeCount p = length $ filter (isCube' . product) $ map ([p,2*p,3*p]++) $ subsequences $ delete (2*p) [p+1..3*p-1]
