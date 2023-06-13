module HelperSequences.A066628Spec (main, spec) where
import Test.Hspec
import HelperSequences.A066628 (a066628)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A066628" $
  it "correctly computes the first 20 elements" $
    take 20 (map a066628 [0..]) `shouldBe` expectedValue where
      expectedValue = [0, 0, 0, 0, 1, 0, 1, 2, 0, 1, 2, 3, 4, 0, 1, 2, 3, 4, 5, 6]
