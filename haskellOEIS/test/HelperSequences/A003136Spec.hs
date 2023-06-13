module HelperSequences.A003136Spec (main, spec) where
import Test.Hspec
import HelperSequences.A003136 (a003136)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A003136" $
  it "correctly computes the first 20 elements" $
    take 20 (map a003136 [1..]) `shouldBe` expectedValue where
      expectedValue = [0, 1, 3, 4, 7, 9, 12, 13, 16, 19, 21, 25, 27, 28, 31, 36, 37, 39, 43, 48]
