-- How many polynomials of degree k in Z_n[x] that are 0 under every evaluation map?

-- coefficientList generates polynomials of degree k.
coefficientList :: Int -> Int -> [[Int]]
coefficientList n k = recurse k $ map (:[]) [1..n-1] where
  recurse 0 ls = ls
  recurse c ls = recurse (c - 1) [a : as | a <- [0..n-1], as <- ls]

coefficientList' :: Int -> Int -> [[Int]]
coefficientList' n k = recurse k [[1]] where
  recurse 0 ls = ls
  recurse c ls = recurse (c - 1) [a : as | a <- [0, 1], as <- ls]

nonzeroZeroes n k = filter (`nonzeroZero` n) $ coefficientList n k

nonzeroZeroes' n k = filter (`nonzeroZero` n) $ coefficientList' n k

nonzeroZero coeffs n = all ((==0) . (`mod` n) . evaluate coeffs) [0..n]

-- evaluate [1,2,3] 10 = 1 + 2*10 + 3*100 = 321
evaluate coeffs k = recurse 0 1 coeffs where
  recurse s _ []     = s
  recurse s x (c:cs) = recurse (s + c*x) (x*k) cs

-- Table read by rows: T(n,k) gives the number of degree k polynomials with
-- coefficients in Z/nZ that evaluate to 0 for all values in Z/nZ, with n > 1, k > 0
-- 2: 0, 1,  2,  4,   8,   16,    32, ...
-- 3: 0, 0,  2,  6,  18,   54,   162, ...
-- 4: 0, 1,  2, 12,  48,  192,   768, ...
-- 5: 0, 0,  0,  0,   4,   20,   100, ...
-- 6: 0, 1, 10, 60, 360, 2160, 12960, ...
-- 7: 0, 0,  0,  0,   0,    0,     6, ...

-- Table read by rows: T(n,k) gives the number of degree k polynomials with
-- coefficients in {0,1} that evaluate to 0 (mod n) for all values in Z/nZ, with n > 1, k > 0.
-- 2: 0,1,2,4,8,16,32, ...
-- 3: 0,0,0,0,1,2,6,15,30,66,121,242,... (https://oeis.org/draft/A329479)
-- 4: 0,0,0,0,1,2,6,10,20,32,64,120,256,512,1056,2080,4160,8192,16384,32640,65536,131072,...
-- 5: 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,4,8,40,...
-- 6: 0,0,0,0,0,1,3,12,24,60,101,202,312,573,903,1785,3248
-- 7: 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,^CInterrupted.
-- 8: 0,0,0,0,0,0,0,0,0,1,4,20,50,150,300,700,...

-- Idea, count up to scaling. So 2x + 1 and x + 2 are the same (mod 3)
-- Complication: Are 2x and 0 the same (mod 6), via multiplication by 3?

-- Idea, 0-1 polynomials with exactly n 1s.
-- 2: 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
-- 3: 0,0,0,0,1,1,3,3,6,6,10,10,15,15,21,21,28,28,36
-- 4: 0,0,0,0,1,2,6,10,19,28,44,60,85,110,146,182,231
-- 5: 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,5
-- 6: 0,0,0,0,0,1,3,12,24,60,101,201,306,531,756,1197
-- 7: 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,^CInterrupted.

-- Idea, some minimality condition on polynomials. For example, for n = 2,
-- don't count x^3 + x^2 = x(x^2 + x) since x^2 + x works.

-- Idea, polynomials that are bijections under the evaluation map.
