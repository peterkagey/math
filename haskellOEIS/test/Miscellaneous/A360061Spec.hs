module Miscellaneous.A360061Spec (main, spec) where
import Test.Hspec
import Miscellaneous.A360061 (a360061)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A360061" $
  it "correctly computes the first 20 elements" $
    map a360061 [1..20] `shouldBe` expectedValue where
      expectedValue = [2,3,4,12,48,54,66,138,144,162,168,180,198,234,252,264,330,360,366,372]
