import Data.Ratio

palindromeCounter :: Integer->Integer->Integer
palindromeCounter 0 b = 0
palindromeCounter 1 b = 0
palindromeCounter n b = 3^ceiling(n%2)
                        + palindromeCounter (n-1) b * b
                        - palindromeCounter (ceiling (n%2)) b
