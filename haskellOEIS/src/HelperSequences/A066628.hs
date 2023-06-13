module HelperSequences.A066628 (a066628) where
import HelperSequences.A087172 (a087172)

a066628 :: Integer -> Integer
a066628 0 = 0
a066628 n = n - a087172 n
