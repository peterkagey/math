import Data.Matrix (matrix, inverse, nrows, multStd, toList)
import Data.Ratio ((%))

recursionMatrix n integerSequence = matrix n n (\(i,j) -> integerSequence !! (i + j - 2) % 1)
solutionMatrix n integerSequence = matrix n 1 (\(i,_) -> integerSequence !! (i + n - 1) % 1)

targetInverse integerSequence = (case biggestInverse of Right m -> m) where
  biggestInverse = last $ takeWhile isRight allInverses where
    allInverses = map (\n -> inverse $ recursionMatrix n integerSequence) [1..]
    allSolutions = map (`solutionMatrix` integerSequence) [1..]

recursion integerSequence = toList $ multStd inverseMatrix (solutionMatrix matrixSize integerSequence) where
  inverseMatrix = targetInverse integerSequence
  matrixSize = nrows inverseMatrix

isRight (Right _) = True
isRight (Left _) = False

-- Conjecture:
-- A320099
-- 103*a(n-1) + 1063*a(n-2) - 1873*a(n-3) - 20274*a(n-4) + 44071*a(n-5) - 10365*a(n-6) - 20208*a(n-7) + 5959*a(n-8) + 2300*a(n-9) - 500*a(n-10) # for n > 10
