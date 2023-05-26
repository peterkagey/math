menageCount :: Int -> Integer -> Prefix
menageCount n = unrank n n (menagePrefixCount n)

derangementCount :: Int -> Integer -> Prefix
derangementCount n = unrank n n (derangementPrefixCount n)

invalidMenagePrefix :: Int -> Prefix -> Bool
invalidMenagePrefix n prefix = containsDuplicates || invalidPosition where
  containsDuplicates = prefix /= (nub prefix)
  invalidPosition = any inRestrictedPosition $ zip [0..] prefix where
    inRestrictedPosition (i, x) = (x `mod` n == i) || (x == i + 1)

menagePrefixCount :: Int -> Prefix -> Integer
menagePrefixCount n prefix
  | invalidMenagePrefix n prefix = 0
  | otherwise      = recurse 0 crp where
  n' = fromIntegral (n - length prefix)
  crp = complementaryRookPolynomial n prefix
  recurse k (c:cs) = (-1)^k * c * factorial (n'-k) + recurse (k+1) cs
  recurse _ [] = 0

-- The polynomial a + bx + cx^2 ... is represented as
-- [a, b, c, ...]
-- These are helper functions for adding and multiplying polynomials
(.+.) :: Coefficients -> Coefficients -> Coefficients
(.+.) p1 [] = p1
(.+.) [] p2 = p2
(.+.) (a:p1) (b:p2) = (a + b) : (p1 .+. p2)

(.*.) :: Coefficients -> Coefficients -> Coefficients
(.*.) p1 [] = []
(.*.) [] p2 = []
(.*.) p1 p2 = foldr1 (.+.) termwiseProduct where
  termwiseProduct = map f $ zip [0..] p1 where
    f (i, x) = replicate i 0 ++ map (*x) p2

factorial :: Integer -> Integer
factorial n = factorial' n 1 where
  factorial' 0 accum = accum
  factorial' n accum = factorial' (n - 1) (accum * n)

binomial :: Integer -> Integer -> Integer
binomial _ 0 = 1
binomial 0 _ = 0
binomial n k
  | n < k'    = 0
  | otherwise = product [k' + 1..n] `div` factorial (n - k') where
    k' = max k (n - k)
