import Control.Monad (replicateM)
import Data.List (tails)

-- Necklace | Bracelet | Invert | Invert Bracelet

isMinimalNecklace necklace = necklace == (minimum allRotations) where
  n = length necklace
  allRotations = take n $ map (take n) $ tails $ cycle necklace

isMinimalBracelet necklace = necklace == (minimum (allRotations ++ reversedRotations)) where
  n = length necklace
  allRotations = take n $ map (take n) $ tails $ cycle necklace
  reversedRotations = map reverse allRotations

invert = map (\x -> 1 - x)

isMinimalInvertibleNecklace necklace = necklace == (minimum (allRotations ++ invertedNecklaces)) where
  n = length necklace
  allRotations = take n $ map (take n) $ tails $ cycle necklace
  invertedNecklaces = map invert allRotations

isMinimalInvertibleBracelet bracelet = bracelet == (minimum (allBracelets ++ invertedBracelets)) where
  n = length bracelet
  allRotations = take n $ map (take n) $ tails $ cycle bracelet
  flippedNecklaces = map reverse allRotations
  allBracelets = allRotations ++ flippedNecklaces
  invertedBracelets = map invert allBracelets

allWords n = replicateM n [0,1]

a356921_rows = concatMap (filter isMinimalNecklace . allWords) [1..]
a356921_list = concat a356921_rows


a356922_rows = concatMap (filter isMinimalBracelet . allWords) [1..]
a356922_list = concat a356922_rows

a356923_rows = concatMap (filter isMinimalInvertibleNecklace . allWords) [1..]
a356923_list = concat a356923_rows

a356924_rows = concatMap (filter isMinimalInvertibleBracelet . allWords) [1..]
a356924_list = concat a356924_rows
