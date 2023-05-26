import Data.List (permutations, sort, intercalate, transpose)
import Data.Ratio (Ratio, (%))

type Permutation = [Int]

-- makeRow :: (Permutation -> Int) -> Int -> [Rational]
makeRow stat n = valuesAndFirstLetters where
  valuesAndFirstLetters = sort $ map (valueAndFirstLetter stat) $ permutations [1..n]

valueAndFirstLetter :: (Permutation -> Int) -> Permutation -> (Int, Int)
valueAndFirstLetter stat pi = (stat pi, head pi)

histogram :: [(Int, Int)] -> [(Int,Int)]
histogram [] = []
histogram xs@((x,_):_) = case span ((==x) . fst) xs of (as, bs) -> (sum (map snd as), length as) : histogram bs

majorIndex :: Permutation -> Int
majorIndex = recurse 1 0 where
  recurse i c (p:p':ps) = recurse (i + 1) (if p > p' then c + i else c) (p':ps)
  recurse i c _         = c

formatTable :: Show a => [[a]] -> [String]
formatTable as = map (Data.List.intercalate ", " . take 10 . zipWith pad lengths) as where
  lengths = map maximum $ transpose $ map (map (length . show)) as
  pad n a = replicate (n - length a') ' ' ++ a' where
    a' = show a

mDescents :: Int -> Permutation -> Int
mDescents m x = length $ filter (uncurry (>)) $ x `zip` drop m x
