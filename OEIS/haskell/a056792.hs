--(Haskell)
c i = if i `mod` 2 == 0 then i `div` 2 else i - 1

b 0 foldCount = foldCount
b sheetCount foldCount = b (c sheetCount) (foldCount + 1)

a056792 n = b n 0 -- ~~~~
