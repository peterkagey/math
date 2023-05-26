import Data.Ratio (Ratio, (%), denominator, numerator)
import Data.List (genericLength)
import Math.NumberTheory.Powers.Squares (isSquare')
import qualified Data.Map.Strict as Map

type Histogram = Map.Map Integer Int

partitionsOf :: Integer -> [[Integer]]
partitionsOf n = partitionsWithMaxPart n n

partitionsWithMaxPart :: Integer -> Integer -> [[Integer]]
partitionsWithMaxPart 0 _ = [[]]
partitionsWithMaxPart n maxPart = concatMap nextGeneration $ reverse [1..maxPart `min` n] where
  nextGeneration firstTerm = map (firstTerm:) $ partitionsWithMaxPart (n - firstTerm) firstTerm

mean :: [Integer] ->  Ratio Integer
mean xs = (sum xs) % (genericLength xs)

variance :: [Integer] ->  Ratio Integer
variance xs = varianceNumerator / varianceDenominator where
  mu = mean xs
  varianceNumerator = sum $ map (\x -> (x % 1 - mu)^2) xs
  varianceDenominator = genericLength xs

isRichardsSequence :: [Integer] -> Bool
isRichardsSequence xs = shifted && notReversible && fewerThanThreeOccurrences && noCommonFactor && meanIsInteger && varianceIsInteger && stdDevIsInteger && positiveVariance where
  shifted = last xs == 0
  notReversible = centralize xs <= centralize (map (*(-1)) $ reverse xs)
  fewerThanThreeOccurrences = maxOccurrences xs < 3
  noCommonFactor = foldr1 gcd xs == 1
  meanIsInteger = denominator (mean xs) == 1
  var = variance xs
  varianceIsInteger = denominator var == 1
  stdDevIsInteger = isSquare' (numerator var)
  positiveVariance = var > 1

adjust = map (map (subtract 1))

centralize xs = map (subtract mu) xs where
  mu = numerator $ mean xs

makeHistogram :: [Integer] -> Histogram
makeHistogram xs = recurse Map.empty xs where
  recurse partialHistogram [] = partialHistogram
  recurse partialHistogram (k:ks) = recurse updatedHistogram ks where
    updatedHistogram = Map.insertWith (\_ a -> a+1) k 1 partialHistogram

maxOccurrences :: [Integer] -> Int
maxOccurrences = Map.foldr max 0 . makeHistogram
