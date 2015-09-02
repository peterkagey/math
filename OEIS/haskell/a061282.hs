--(Haskell)
c i = if i `mod` 3 == 0 then i `div` 3 else i - 1

b 0 foldCount = foldCount
b sheetCount foldCount = b (c sheetCount) (foldCount + 1)

a061282 n = b n 0 -- ~~~~
