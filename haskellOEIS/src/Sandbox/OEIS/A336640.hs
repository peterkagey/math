a336640_list = map a336640 [0..]

a336640 0 = 0
a336640 n = maximum $ map (\(i, t) -> i + (a336640_list !! (n - t))) triangular where
  triangular = takeWhile (\(_, m) -> m <= n) $ map t [2..] where
    t i = (i, i*(i-1) `div` 2)
