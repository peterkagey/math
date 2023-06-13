import Data.List (findIndices, sort, tails, maximum, nub)
import Data.Set (Set)
import qualified Data.Set as Set
import Helpers.Binary (bitsList)
import Helpers.Subsets (eachPair)

commonPrefix (w1, w2) = recurse w1 w2 where
  recurse [] _ = []
  recurse _ [] = []
  recurse (a:as) (b:bs)
    | a == b    = a : recurse as bs
    | otherwise = []

longestRepeatedSubstrings w = allMax length $ map commonPrefix pairs where
  prefixes = sort $ tails w
  pairs = zip prefixes (tail prefixes)

-- longestRepeatedSubstringWithoutOverlap w = maximum $ map f pairs where
--   f (a,b) = minimum [lengthOfCommonPrefix (a, b), abs (length a - length b)]
--   prefixes = sort $ tails w
--   pairs = zip prefixes (tail prefixes)

allMax :: (a -> Int) -> [a] -> [a]
allMax _ []     = []
allMax f (a:as) = recurse [a] (f a) as where
  recurse known _ []  = known
  recurse known knownMin (x:xs)
    | f x == knownMin = recurse (x : known) knownMin xs
    | f x < knownMin  = recurse       known knownMin xs
    | otherwise       = recurse         [x]    (f x) xs

a354614 = length . Data.List.nub . longestRepeatedSubstrings . bitsList
a354614_list = map a354614 [0..]

-- https://stackoverflow.com/questions/27523398/creating-a-list-of-substrings-of-a-specified-length-in-haskell
allSubs :: Int -> [a] -> [[a]]
allSubs 0 _ = []
allSubs n s
    | length s >= n = take n s : allSubs n (tail s)
    | otherwise = []

-- deleteLongestRepeatedSubstrings  :: Eq a => [a] -> [[a]]
deleteLongestRepeatedSubstrings w = map snd $ filter (\(i, _) -> i `Set.notMember` indices) $ zip [0..] w where
  isometricSubstrings = longestRepeatedSubstrings w
  n = length $ head isometricSubstrings
  startingIndices = findIndices (`elem` isometricSubstrings) $ allSubs n w
  indices = Set.fromList $ concatMap (\i -> [i..i+n-1]) startingIndices
