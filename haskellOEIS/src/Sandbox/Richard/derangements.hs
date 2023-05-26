import Data.List (delete, intersect, permutations)
import Data.Ratio ((%), numerator, denominator)
import Helpers.Factorials (factorial)

a047920_rows :: [[Integer]]
a047920_rows = recurse 0 [] where
  recurse i row = nextRow : recurse (i + 1) nextRow where
    nextRow = scanl (-) (factorial i) row

a047920 n k = a047920_rows !! n !! k

-- richardsFunction 20 (500*1000*1000*1000*1000*1000)
richardsFunction n k = recurse k 1 [1..n] where
  recurse threshold i choices
    | length newChoices == 1 = nextTerm : newChoices
    | otherwise              = nextTerm : recurse newThreshold (i+1) newChoices where
      (nextTerm, newChoices, newThreshold) = computeNext threshold choices (i + 1, n)

numberOfEarlierTerms choices (k, n) = a047920 (n - k + 1) $ length (choices `intersect` [k..n])

computeNext threshold choices (k, n) = recurse 0 choices where
  recurse sumValue (c:cs)
    | c == k - 1                         = recurse sumValue cs
    | sumValue + newSummand >= threshold = (c, delete c choices, threshold - sumValue)
    | otherwise                          = recurse (sumValue + newSummand) cs where
      newSummand = numberOfEarlierTerms (delete c choices) (k, n)

descents (a':a:as)
  | a' > a    = descents (a:as) + 1
  | otherwise = descents (a:as)
descents _ = 0

average l = sum l % length l

a000166 n = [1, 0, 1, 2, 9, 44, 265, 1854, 14833, 133496, 1334961, 14684570, 176214841, 2290792932, 32071101049, 481066515734, 7697064251745, 130850092279664, 2355301661033953, 44750731559645106, 895014631192902121] !! n

a999999T n k = length $ filter ((==k) . descents) $ map (richardsFunction n) [1..a000166 n]

a332009T n k = numerator $ average $ map head $ filter ((==k) . descents) $ map (richardsFunction n) [1..a000166 n]

a332010T n k = denominator $ average $ map head $ filter ((==k) . descents) $ map (richardsFunction n) [1..a000166 n]

-- Quite slow, because it recomputes richardsFunction each time.
a332009_row n
  | even n    = map (a332009T n) [1..n - 1]
  | otherwise = map (a332009T n) [1..n - 2]

a332010_row n
  | even n    = map (a332010T n) [1..n - 1]
  | otherwise = map (a332010T n) [1..n - 2]

numberOfFixedPoints l = length $ filter (uncurry (==)) $ zip [1..] l
