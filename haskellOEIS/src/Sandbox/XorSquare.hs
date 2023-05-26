import Data.List (tails)
import Data.Set (Set)
import qualified Data.Set as Set

toBase2 digits number
  | number >= 2^digits = error "too big!"
  | otherwise = recurse digits number [] where
  recurse 0 _ known = known
  recurse d n known = recurse (d - 1) (n `div` 2) (n `mod` 2 : known)

nextRow row = map (`mod` 2) $ (last row + head row) : zipWith (+) row (tail row)

minimumShift row = minimum $ map (take d) $ take d $ tails $ cycle row where
  d = length row

minimumShift' row = minimum $ [minimumShift row, minimumShift row'] where
  row' = map (\i -> 1 - i) row

minimumBracelet row = minimum $ [minimumShift row, minimumShift (reverse row)]

minimumBracelet' row = minimum $ [minimumBracelet row, minimumBracelet row'] where
  row' = map (\i -> 1 - i) row

countSteps d n = countSteps' (toBase2 d n)

countSteps' = recurse 0 Set.empty where
  recurse i knownRows row
    | row' `Set.member` knownRows = i
    | otherwise = recurse (i + 1) (Set.insert row' knownRows) (nextRow row) where
      row' = minimumShift row

countSteps'' = recurse 0 Set.empty where
  recurse i knownRows row
    | row `Set.member` knownRows = i
    | otherwise = recurse (i + 1) (Set.insert row knownRows) (nextRow row)

a355255_row 0 = [1]
a355255_row n = map (countSteps n) [0..2^n - 1]

necklaces n = Set.toAscList $ Set.fromList $ map (minimumShift . toBase2 n) [0..2^n-1]

bracelets n = Set.toAscList $ Set.fromList $ map (minimumBracelet . toBase2 n) [0..2^n-1]

necklaces' n = Set.toAscList $ Set.fromList $ map (minimumShift' . toBase2 n) [0..2^n-1]

bracelets' n = Set.toAscList $ Set.fromList $ map (minimumBracelet' . toBase2 n) [0..2^n-1]
