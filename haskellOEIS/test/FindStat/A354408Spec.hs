module FindStat.A354408Spec (main, spec) where
import Test.Hspec
import FindStat.A354408 (a354408)

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "A354408" $
  it "correctly computes the first 20 elements" $
    take 20 (map a354408 [2..]) `shouldBe` expectedValue where
      expectedValue = [0, 1, 1, 2, 4, 2, 13, 13, 13, 13, 80, 82, 80, 82, 80, 579, 579, 579, 579, 579]
