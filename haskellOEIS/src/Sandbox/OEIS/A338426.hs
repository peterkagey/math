a338426 :: Int -> Integer
a338426 = (!!) a338426_list

a338426_list :: [Integer]
a338426_list = 1 : 2 : 28 : 154 : 1206 : 8364 : 60614 : 432636 : recurse a338426_list where
  recurse as@(a8:a7:a6:a5:a4:a3:a2:a1:_) = 7*a1 + 6*a2 - 39*a3 + 29*a4 + 28*a5 - 26*a6 - 10*a7 + 6*a8 : recurse (tail as)
