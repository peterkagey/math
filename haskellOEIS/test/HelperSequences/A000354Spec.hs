module HelperSequences.A000354Spec (main,spec) where
import Test.Hspec
import HelperSequences.A000354 (a000354)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A000354" $
  it "correctly computes the first 10 elements" $
    take 10 (map a000354 [0..]) `shouldBe` expectedValue where
      expectedValue = [1,1,5,29,233,2329,27949,391285,6260561,112690097]
