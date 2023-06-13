module Polynomial.A350532Spec (main, spec) where
import Test.Hspec
import Polynomial.A350532 (a350532)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A350532" $
  it "correctly computes the first 20 elements" $
    map a350532 [0..19] `shouldBe` expectedValue where
      expectedValue = [1, 0, 0, 1, 1, 0, 1, 0, 0, 1, 1, 2, 1, 0, 0, 1, 0, 0, 1, 0]
