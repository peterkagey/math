import Math.NumberTheory.Primes.Testing (isPrime)
a360061_list = 2 : 3 : recurse 4 13 where
  recurse n p
    | isPrime(n^2 + p) = n : recurse (n+1) (n^2 + p)
    | otherwise        = recurse (n+1) p
-- ~~~~

a_list = 2 : recurse 3 2 where
  recurse n p
    | isPrime(n + p) = (n + p) : recurse (n+1) (n + p)
    | otherwise        = recurse (n+1) p
-- ~~~~
