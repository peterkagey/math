import Sandbox.GridTiles.Rotation (D8(..))

type Specification = (Integer, Integer, Integer, Integer, Integer, Integer, Integer, Integer)

fxpt :: D8 -> Specification -> Integer -> Integer
fxpt g tileCounts n
  | g == I           = t^(n^2)
  | g == P && even n = t^(n^2 `div` 4)
  | g == P &&  odd n = t^((n^2 - 1) `div` 4)*(a1 + 2*a2)
  | g == R && even n = t^(n^2 `div` 2)
  | g == R &&  odd n = t^((n^2 - 1) `div` 2)*(a1 + 2*a2 + 4*a3 + 2*a6 + 2*a7)
  | g == H && even n = t^(n^2 `div` 2)
  | g == H &&  odd n = t^((n^2 - n) `div` 2)*(a1 + 2*a4 + 2*a6)^n
  | g == D           = t^((n^2 - n) `div` 2)*(a1 + 2*a5 + 2*a7)^n
  | g == V           = fxpt H tileCounts n
  | g == N           = fxpt P tileCounts n
  | g == A           = fxpt D tileCounts n where
    (a1, a2, a3, a4, a5, a6, a7, a8) = tileCounts
    t = a1 + 2*a2 + 4*a3 + 4*a4 + 4*a5 + 2*a6 + 2*a7 + 8*a8

-- a1 fixed under <r, f>    => 1
-- a2 fixed under <r>       => 2
-- a3 fixed under <r^2>     => 4
-- a4 fixed under <f>       => 4
-- a5 fixed under <rf>      => 4
-- a6 fixed under <r^2, f>  => 2
-- a7 fixed under <r^2, rf> => 2
-- a8 fixed under <>        => 8

f tileCounts n = fixedPoints `div` 8 where
  fixedPoints = sum $ map (\g -> fxpt g tileCounts n) [I, P, R, N, H, V, D, A]

-- a_1 = 2 => A054247
-- a_5 = 1 => A302484
-- a_7 = 1 => A295229

-- (1,0,0,0,0,0,0,0) => 1,   1,        1,              1,                      1
-- (0,1,0,0,0,0,0,0) => 1,   4,       70,           8292,                4195360
-- (0,0,1,0,0,0,0,0) => 1,  39,    32896,      536895552,        140737496743936
-- (0,0,0,1,0,0,0,0) => 1,  39,    32896,      536895552,        140737496743936
-- (0,0,0,0,1,0,0,0) => 1,  43,    32896,      536911936,        140737496743936
-- (0,0,0,0,0,1,0,0) => 1,   4,       84,           8292,                4203520
-- (0,0,0,0,0,0,1,0) => 1,   6,       84,           8548,                4203520
-- (0,0,0,0,0,0,0,1) => 1, 538, 16777216, 35184378381312, 4722366482869645213696
