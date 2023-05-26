module Poset.A999998Spec (main,spec) where
import Test.Hspec
import Poset.A999998 (a999998)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A999998" $
  it "correctly computes the first 20 elements" $
    map a999998 [1..20] `shouldBe` expectedValue where
      expectedValue = [2,3,4,6,5,6,8,10,7,9,12,14,10,12,16,18,11,15,20,22]
