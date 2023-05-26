import Data.List (nub)

allMonicPolynomials :: [Integer] -> Integer -> [[Integer]]
allMonicPolynomials coeffs d = recurse d [[1]] where
  recurse 0 ps = ps
  recurse c ps = recurse (c-1) $ concatMap (\p -> map (:p) coeffs) ps

evaluate :: Integer -> [Integer] -> Integer
evaluate x = foldr1 (\c accum -> c + x * accum)

isInKernels :: Integer     -- Modulus: n
              -> [Integer] -- Polynomial coefficients: p(x) = a_0 + a_1*x + ... + a_n*x^n.
              -> Bool      -- Is p(x) divisible by n for all inputs?
isInKernels n ps
  -- | redundantCoefficientValues n ps = error "Improper coefficients!"
  | otherwise = all (\k -> (==0) $ (`mod` n) $ evaluate k ps) [0..n-1]

redundantCoefficientValues n ps = length distinctCoefficients > countDistinctModularCoefficients where
  distinctCoefficients = nub ps
  countDistinctModularCoefficients = length $ nub $ map (`mod` n) distinctCoefficients

kernel ps = filter (`isInKernels` ps) [1.. evaluate 2 ps]
