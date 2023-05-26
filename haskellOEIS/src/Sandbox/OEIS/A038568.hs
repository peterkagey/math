import Data.Ratio ((%), numerator, denominator)

-- A038566
a038566_row 1 = [1]
a038566_row n = filter (\k -> gcd k n == 1) [1..n-1]

a038566_list = concatMap a038566_row [1..]

smallFracRow 1 = [1%1]
smallFracRow n = map (%n) $ filter (\k -> gcd k n == 1) [1..n-1]

smallFracList = concatMap smallFracRow [1..]

allFracList = tail $ concatMap (\frac -> [numerator frac, denominator frac]) smallFracList

-- A002487
