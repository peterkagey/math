-- 3 X 3 torus tiled with diagonals, up to rotation, reflection, and shifting.
-- Cf. A295223.

type Tiling =
  (
    (Bool, Bool, Bool),
    (Bool, Bool, Bool),
    (Bool, Bool, Bool)
  )

shiftDown :: Tiling -> Tiling
shiftDown (a, b, c) = (c, a, b)

shiftRight :: Tiling -> Tiling
shiftRight ((a1, a2, a3), (b1, b2, b3), (c1, c2, c3)) = ((a3, a1, a2), (b3, b1, b2), (c3, c1, c2))

turnPage :: Tiling -> Tiling
turnPage ((a1, a2, a3), (b1, b2, b3), (c1, c2, c3)) =
  (
    (not a3, not a2, not a1),
    (not b3, not b2, not b1),
    (not c3, not c2, not c1)
  )

rotate90 :: Tiling -> Tiling
rotate90 ((a1, a2, a3), (b1, b2, b3), (c1, c2, c3)) =
  (
    (not a3, not b3, not c3),
    (not a2, not b2, not c2),
    (not a1, not b1, not c1)
  )

rows :: [(Bool, Bool, Bool)]
rows = [(x1, x2, x3) | x1 <- [True, False], x2 <- [True, False], x3 <- [True, False]]

allConfigurations = [(r1, r2, r3) | r1 <- rows, r2 <- rows, r3 <- rows]

iterateN :: Int -> (a -> a) -> [a] -> [a]
iterateN n f as = as ++ recurse n as where
  recurse 1  _   = []
  recurse n' as' = as'' ++ recurse (n' - 1) as'' where
    as'' = map f as'

canonical :: Tiling ->  Tiling
canonical t = minimum $ foldr (uncurry iterateN) [t] actions where
  actions = [(2, turnPage), (4, rotate90), (3, shiftRight), (3, shiftDown)]

s b = if b then "1" else "0"

-- Latex command for \x/\y/\s
-- % (\x, \y-3+\s)--(\x-2, \y-2-\s)
-- (\x +       0.5*\s, \y-3 + 0.5 - 0.5*\s) arc (270+90*\s:360+90*\s:0.5)
-- (\x + 0.5 + 0.5*\s, \y-3 +       0.5*\s) arc (180+90*\s:90+90*\s:0.5)
-- % (\x, \y+\s)--(\x-2, \y+1-\s)
-- (\x +       0.5*\s, \y + 0.5 - 0.5*\s) arc (270+90*\s:360+90*\s:0.5)
-- (\x + 0.5 + 0.5*\s, \y +       0.5*\s) arc (180+90*\s:90+90*\s:0.5)
-- % (\x, \y+3+\s)--(\x-2, \y+4-\s)
-- (\x +       0.5*\s, \y+3 + 0.5 - 0.5*\s) arc (270+90*\s:360+90*\s:0.5)
-- (\x + 0.5 + 0.5*\s, \y+3 +       0.5*\s) arc (180+90*\s:90+90*\s:0.5)
printTiling ((a1, a2, a3), (b1, b2, b3), (c1, c2, c3)) =
  "0/0/" ++ s a1 ++ ", 1/0/" ++ s a2 ++ ", 2/0/" ++ s a3 ++ ", " ++
  "0/1/" ++ s b1 ++ ", 1/1/" ++ s b2 ++ ", 2/1/" ++ s b3 ++ ", " ++
  "0/2/" ++ s c1 ++ ", 1/2/" ++ s c2 ++ ", 2/2/" ++ s c3
