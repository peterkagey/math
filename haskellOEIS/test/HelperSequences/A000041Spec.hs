module HelperSequences.A000041Spec (main, spec) where
import Test.Hspec
import HelperSequences.A000041 (a000041)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A000041" $
  it "correctly computes the first 20 elements" $
    take 20 (map a000041 [0..]) `shouldBe` expectedValue where
      expectedValue = [1, 1, 2, 3, 5, 7, 11, 15, 22, 30, 42, 56, 77, 101, 135, 176, 231, 297, 385, 490]
