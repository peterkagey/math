import Helpers.Primes (divisors,  distinctPrimeFactors)
import Helpers.Factorials (binomial, factorial)

r_i candidates i = filter ((==1) . (`mod` i)) candidates

a n = minimum $ map (maximum . r_i cs) $ distinctPrimeFactors n where
  cs = divisors n

specialNumbers = filter (\n -> factorial (a n) `mod` n > 0) $ filter ((>1) . a) [2..]

-- These are numbers where you can use the argument from Algebra Qual Fall 2018 problem 2.
