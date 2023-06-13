module HelperSequences.A087172Spec (main, spec) where
import Test.Hspec
import HelperSequences.A087172 (a087172)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A087172" $
  it "correctly computes the first 20 elements" $
    take 20 (map a087172 [1..]) `shouldBe` expectedValue where
      expectedValue = [1, 2, 3, 3, 5, 5, 5, 8, 8, 8, 8, 8, 13, 13, 13, 13, 13, 13, 13, 13]
