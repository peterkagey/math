import Data.Map (singleton, findMin, deleteMin, insert)
a239870 n = a239870_list !! (n-1)
a239870_list = f 9 (3, 2) (singleton 4 (2, 2)) where
  f zz (bz, ez) m
    | xx < zz = if ex `mod` 3 > 0
      then xx : f zz (bz, ez+1) (insert (bx*xx) (bx, ex+1) $ deleteMin m)
      else      f zz (bz, ez+1) (insert (bx*xx) (bx, ex+1) $ deleteMin m)
    | xx > zz = if ez `mod` 3 > 0
      then zz : f (zz+2*bz+1) (bz+1, 2) (insert (bz*zz) (bz, 3) m)
      else      f (zz+2*bz+1) (bz+1, 2) (insert (bz*zz) (bz, 3) m)
    | otherwise = f (zz+2*bz+1) (bz+1, 2) m
    where (xx, (bx, ex)) = findMin m
