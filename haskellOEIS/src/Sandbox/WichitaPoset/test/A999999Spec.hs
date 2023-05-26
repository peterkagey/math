module Poset.A999999Spec (main,spec) where
import Test.Hspec
import Poset.A999999 (a999999)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A999999" $
  it "correctly computes the first 20 elements" $
    map a999999 [1..20] `shouldBe` expectedValue where
      expectedValue = [1,2,2,4,3,4,6,4,6,5,8,10,6,8,12,7,12,10,12,8]
