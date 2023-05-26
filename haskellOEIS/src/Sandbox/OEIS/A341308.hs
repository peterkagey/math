a237048 n k
  | odd k  = if n `mod` k == 0 then 1 else 0
  | even k = if (n - k `div` 2) `mod` k == 0 then 1 else 0
-- 1,1,2,2,2,3,3,3,3,4,4,4,4,4

a237048_rows = map (\(i,l) -> map (a237048 i) [1..l]) $ zip [1..] rowLengths where
  rowLengths = concatMap (\i -> replicate (i + 1) i) [1..]

a249223_rows = map partialAlternatingSum a237048_rows

partialAlternatingSum = scanl1 (+) . zipWith (*) (cycle [1,-1])

a341308_list = map sum a249223_rows
