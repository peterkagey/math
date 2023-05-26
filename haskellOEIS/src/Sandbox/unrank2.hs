import Data.List (sort, nub, intersect)
import Data.Set (Set)
import qualified Data.Set as Set

type Prefix = [Int]
type Coefficients = [Integer]
type PrefixCount = Prefix -> Integer

-- menageCount :: Int -> Integer -> Prefix
-- menageCount n = unrank n n (menagePrefixCount n)

-- derangementCount :: Int -> Integer -> Prefix
-- derangementCount n = unrank n n (derangementPrefixCount n)

-- -- unrank from alphabet of size n with k letters
-- -- and a way of counting the number of words with a given prefix
-- unrank' :: Set [Int] ->           -- The collection
--            (Prefix -> Integer) -> -- #prefix function
--            Integer ->             -- Unrank at i
--            Prefix                 -- Word at rank i
-- unrank' collection prefixCounter i = recurse (0, 0) 1 [] where
--   recurse :: (Integer, Integer) -> -- index range for prefix (a, b]
--               Int ->               -- candidate for current letter
--               Prefix ->            -- established prefix
--               Prefix               -- word at index
--   recurse (a, b) c prefix
--     | Set.member prefix collection && a == i - 1 && b == i = prefix
--     | Set.member prefix collection                         =
--     | a < i && i <= b                                      = recurse (a, b') 1 (prefix  ++ [c])
--     | otherwise                                            = recurse (b, b'') (c + 1) prefix where
--     b'      = a + prefixCounter (prefix ++ [c, 1])
--     b''     = b + prefixCounter (prefix  ++ [c + 1])

increment [] = error "cannot increment empty word"
increment w  = (init w) ++ [1 + last w]

append w = w ++ [1]

getColGroups :: Int -> Prefix -> [[Int]]
getColGroups n prefix = filter (not . null) $ colGroups where
  cols = 0 : (sort prefix) ++ [n+1]
  colGroups = zipWith (\a b ->  [a+1..b-1]) cols (tail cols)

blockSizesFromPrefix :: Int -> Prefix -> [Int]
blockSizesFromPrefix n prefix = map (sum . map colCells) colGroups where
  colGroups = getColGroups n prefix
  k = length prefix
  colCells c
    | c < k      = 0
    | c == k     = 1
    | c == n     = 1
    | otherwise  = 2

fibonacciPoly :: Int -> Coefficients
fibonacciPoly = (!!) fibonacciPolynomials where
  fibonacciPolynomials = [1] : [1] : recurse [1] [1] where
    recurse f g = h : recurse g h where
      h = ([0,1] .*. f) .+. g

complementaryRookPolynomial :: Int -> Prefix -> Coefficients
complementaryRookPolynomial n prefix = foldr (.*.) [1] blockPolys where
  blockPolys = map (\i -> fibonacciPoly (i + 1)) blockSizes where
    blockSizes = blockSizesFromPrefix n prefix

invalidMenagePrefix :: Int -> Prefix -> Bool
invalidMenagePrefix n prefix = containsDuplicates || invalidPosition where
  containsDuplicates = prefix /= (nub prefix)
  invalidPosition = any inRestrictedPosition $ zip [0..] prefix where
    inRestrictedPosition (i, x) = (x `mod` n == i) || (x == i + 1)

invalidDerangementPrefix :: Int -> Prefix -> Bool
invalidDerangementPrefix _ prefix = containsDuplicates || invalidPosition where
  containsDuplicates = prefix /= (nub prefix)
  invalidPosition = any (id) $ zipWith (==) [1..] prefix

menagePrefixCount :: Int -> Prefix -> Integer
menagePrefixCount n prefix
  | invalidMenagePrefix n prefix = 0
  | otherwise      = recurse 0 crp where
  n' = fromIntegral (n - length prefix)
  crp = complementaryRookPolynomial n prefix
  recurse k (c:cs) = (-1)^k * c * factorial (n'-k) + recurse (k+1) cs
  recurse _ [] = 0

derangementPrefixCount :: Int -> Prefix -> Integer
derangementPrefixCount n prefix
  | invalidDerangementPrefix n prefix = 0
  | otherwise = sum $ map (\j -> term j) [0..squareCount] where
    k = length prefix
    squareCount = fromIntegral $ n - k - length (intersect [k+1..n] prefix)
    n' = fromIntegral n
    k' = fromIntegral k
    term j = (-1)^j * binomial squareCount j * factorial (n' - k' - j)

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
