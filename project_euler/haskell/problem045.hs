module Main where

main :: IO ()
main = do
  let result = p45 (drop 143 hexagonalNumbers) (drop 165 pentagonalNumbers)
  print result

hexagonalNumbers :: [Integer]
hexagonalNumbers = map (\i -> i * (2 * i - 1)) [1..]

pentagonalNumbers :: [Integer]
pentagonalNumbers = map (\i -> i * (3 * i - 1) `div` 2) [1..]

p45 :: [Integer] -> [Integer] -> Integer
p45 (h:hs) (p:ps)
  | h < p = p45 hs (p:ps)
  | h > p = p45 (h:hs) ps
  | otherwise = h
