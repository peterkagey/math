--(Haskell)
c i = if i `mod` 4 == 0 then i `div` 4 else i - 1

b 0 foldCount = foldCount
b sheetCount foldCount = b (c sheetCount) (foldCount + 1)

a260112 n = b n 0 -- ~~~~
