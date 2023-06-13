module HelperSequences.A067824Spec (main, spec) where
import Test.Hspec
import HelperSequences.A067824 (a067824)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A067824" $
  it "correctly computes the first 20 elements" $
    take 20 (map a067824 [1..]) `shouldBe` expectedValue where
      expectedValue = [1, 2, 2, 4, 2, 6, 2, 8, 4, 6, 2, 16, 2, 6, 6, 16, 2, 16, 2, 16]
